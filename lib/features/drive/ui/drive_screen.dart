import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/di/injection.dart';
import '../../../../l10n/l10n.dart';
import '../presentation/cubit/drive_cubit.dart';
import '../../../app/appearance/presentation/cubit/app_appearance_cubit.dart';
import '../../../app/appearance/models/car_icon_model.dart';

class DriveScreen extends StatelessWidget {
  const DriveScreen({super.key, required this.destination, required this.destinationName});
  final LatLng destination;
  final String destinationName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DriveCubit>()..initDrive(
        destination: destination,
        language: Localizations.localeOf(context).languageCode,
      ),
      child: DriveView(
        destination: destination,
        destinationName: destinationName,
      ),
    );
  }
}

class DriveView extends StatefulWidget {
  const DriveView({
    super.key,
    required this.destination,
    required this.destinationName,
  });
  final LatLng destination;
  final String destinationName;

  @override
  State<DriveView> createState() => _DriveViewState();
}

class _DriveViewState extends State<DriveView> {
  GoogleMapController? _mapController;
  BitmapDescriptor? _carIconDescriptor;
  CarIconType? _lastLoadedType;
  BitmapDescriptor? _radarIcon;
  LatLng? _lastCameraTarget;
  double? _lastCameraBearing;

  @override
  void initState() {
    super.initState();
    _loadRadarIcon();
  }

  Future<void> _loadRadarIcon() async {
    final descriptor = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(32, 32)),
      'assets/images/radar.png',
    );
    if (mounted) {
      setState(() {
        _radarIcon = descriptor;
      });
    }
  }

  Future<void> _updateCarIcon(CarIconType type) async {
    if (type == _lastLoadedType) return;
    if (type == CarIconType.classic) {
      setState(() {
        _carIconDescriptor = null;
        _lastLoadedType = type;
      });
      return;
    }

    final descriptor = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      type.assetPath,
    );
    
    if (mounted) {
      setState(() {
        _carIconDescriptor = descriptor;
        _lastLoadedType = type;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocConsumer<DriveCubit, DriveState>(
            listener: (context, state) {
              if (state is Loaded && state.isNavigating && state.userPosition != null && _mapController != null) {
                final userPos = state.userPosition!;
                final userBearing = state.bearing;

                final lastPos = _lastCameraTarget;
                final lastBearing = _lastCameraBearing;

                double distMoved = 100.0;
                if (lastPos != null) {
                  distMoved = Geolocator.distanceBetween(
                    lastPos.latitude,
                    lastPos.longitude,
                    userPos.latitude,
                    userPos.longitude,
                  );
                }

                double bearingDiff = 100.0;
                if (lastBearing != null) {
                  bearingDiff = (userBearing - lastBearing).abs() % 360;
                  if (bearingDiff > 180) bearingDiff = 360 - bearingDiff;
                }

                // Update camera more aggressively so navigation feels continuous
                if (distMoved > 0.8 || bearingDiff > 1.5 || lastPos == null || lastBearing == null) {
                  final smoothedTarget = lastPos == null
                      ? userPos
                      : _interpolateLatLng(lastPos, userPos, 0.7);
                  final smoothedBearing = lastBearing == null
                      ? userBearing
                      : _interpolateBearing(lastBearing, userBearing, 0.5);

                  _lastCameraTarget = smoothedTarget;
                  _lastCameraBearing = smoothedBearing;

                  _mapController!.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: smoothedTarget,
                        zoom: 18,
                        tilt: 45,
                        bearing: smoothedBearing,
                      ),
                    ),
                  );
                }
              }
            },
            builder: (context, state) {
              return switch (state) {
                Initial() || Loading() => const Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  ),
                DriveError(errorKey: final key) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(key, style: const TextStyle(color: Colors.red)),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<DriveCubit>().initDrive(destination: widget.destination);
                          },
                          child: Text(context.l10n.retryButtonLabel),
                        ),
                      ],
                    ),
                  ),
                Loaded(origin: final origin, destination: final destination, directions: final directions) =>
                  BlocBuilder<AppAppearanceCubit, AppAppearanceState>(
                    builder: (context, appearance) {
                      _updateCarIcon(appearance.carIcon);
                      
                      final useClassic = appearance.carIcon == CarIconType.classic;
                      
                      return GoogleMap(
                        onMapCreated: (controller) {
                          _mapController = controller;
                          if (!state.isNavigating) {
                            controller.animateCamera(
                              CameraUpdate.newLatLngBounds(
                                LatLngBounds(
                                  southwest: directions.boundsSw,
                                  northeast: directions.boundsNe,
                                ),
                                50,
                              ),
                            );
                          }
                        },
                        initialCameraPosition: CameraPosition(
                          target: origin,
                          zoom: 12,
                        ),
                        myLocationEnabled: useClassic,
                        myLocationButtonEnabled: false,
                        trafficEnabled: true,
                        zoomControlsEnabled: false,
                        markers: {
                          Marker(
                            markerId: const MarkerId('destination'),
                            position: destination,
                            infoWindow: InfoWindow(title: widget.destinationName),
                            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                          ),
                          if (!useClassic && state.userPosition != null && _carIconDescriptor != null)
                            Marker(
                              markerId: const MarkerId('user_position'),
                              position: state.userPosition!,
                              icon: _carIconDescriptor!,
                              rotation: state.bearing,
                              anchor: const Offset(0.5, 0.5),
                              flat: true,
                            ),
                          // Radar markers
                          ...state.nearbyRadars.map((radar) => Marker(
                                markerId: MarkerId('radar_${radar.latitude}_${radar.longitude}'),
                                position: radar,
                                icon: _radarIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
                                anchor: const Offset(0.5, 0.5),
                              )),
                        },
                        polylines: {
                          Polyline(
                            polylineId: const PolylineId('route'),
                            points: directions.polylinePoints,
                            color: Colors.blue.shade700,
                            width: 5,
                          ),
                        },
                      );
                    },
                  ),
              };
            },
          ),

          // Navigation Instruction Panel
          BlocBuilder<DriveCubit, DriveState>(
            builder: (context, state) {
              if (state is! Loaded || !state.isNavigating) return const SizedBox.shrink();
              
              final currentStepIndex = state.currentStepIndex;
              final steps = state.directions.steps;
              
              if (currentStepIndex >= steps.length) {
                return Positioned(
                  top: MediaQuery.of(context).padding.top + 16,
                  left: 16,
                  right: 16,
                  child: _InstructionCard(
                    instruction: context.l10n.destinationReached,
                    distance: '',
                    isArrival: true,
                  ),
                );
              }

              final step = steps[currentStepIndex];

              return Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                right: 16,
                child: _InstructionCard(
                  instruction: _stripHtml(step.instruction),
                  distance: _formatDistance(state.distanceToNextStep),
                ),
              );
            },
          ),
          
          // Back Button (hidden during navigation)
          BlocBuilder<DriveCubit, DriveState>(
            builder: (context, state) {
              if (state is Loaded && state.isNavigating) return const SizedBox.shrink();
              return Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10),
                      ],
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                  ),
                ),
              );
            },
          ),

          // Bottom Info Panel
          BlocBuilder<DriveCubit, DriveState>(
            builder: (context, state) {
              if (state is! Loaded) return const SizedBox.shrink();

              final isNavigating = state.isNavigating;
              final directions = state.directions;

              if (!isNavigating) {
                return Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + MediaQuery.of(context).padding.bottom),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -5)),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.destinationName,
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.directions_car_rounded, size: 14, color: Colors.grey.shade400),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${directions.totalDistance} • ${directions.totalDuration}',
                                        style: GoogleFonts.inter(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          height: 64,
                          child: ElevatedButton(
                            onPressed: () {
                              HapticFeedback.mediumImpact();
                              context.read<DriveCubit>().startNavigation();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              elevation: 0,
                            ),
                            child: Text(
                              context.l10n.startNavigation.toUpperCase(),
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.grey.shade600,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(color: Colors.grey.shade200),
                              ),
                            ),
                            child: Text(
                              context.l10n.mainMenu.toUpperCase(),
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).padding.bottom),
                      ],
                    ),
                  ),
                );
              }

              // Navigation stats view
              final remainingDistFixed = (directions.totalDistanceValue - state.traveledDistance).clamp(0, double.infinity);
              final remainingDurationFixed = (directions.totalDurationValue * (remainingDistFixed / directions.totalDistanceValue)).round();
              
              final elapsedTime = state.startTime != null ? DateTime.now().difference(state.startTime!) : Duration.zero;

              return Stack(
                children: [
                  Positioned(
                    bottom: 130 + MediaQuery.of(context).padding.bottom,
                    left: 20,
                    child: _Speedometer(
                      speed: state.currentSpeed,
                      limit: state.currentSpeedLimit,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(24, 20, 24, 20 + MediaQuery.of(context).padding.bottom),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -5)),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        _formatDuration(remainingDurationFixed),
                                        style: GoogleFonts.inter(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.green.shade700,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      _formatDistance(remainingDistFixed),
                                      style: GoogleFonts.inter(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      '${context.l10n.alreadyBehindYou}: ${_formatElapsedTime(elapsedTime)} • ${_formatDistance(state.traveledDistance)}',
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: 56,
                            height: 56,
                            child: IconButton.filled(
                              onPressed: () {
                                HapticFeedback.mediumImpact();
                                context.read<DriveCubit>().stopNavigation();
                              },
                              icon: const Icon(Icons.close_rounded),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.red.shade50,
                                foregroundColor: Colors.red.shade600,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  String _formatDuration(num seconds) {
    if (seconds < 60) return '1 min';
    final minutes = (seconds / 60).round();
    if (minutes >= 60) {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      return '${hours}h ${remainingMinutes}m';
    }
    return '$minutes min';
  }

  String _formatDistance(num meters) {
    if (meters < 1000) return '${meters.round()} m';
    final km = meters / 1000;
    return '${km.toStringAsFixed(1)} km';
  }

  String _formatElapsedTime(Duration duration) {
    final minutes = duration.inMinutes;
    if (minutes >= 60) {
      final hours = duration.inHours;
      final remainingMinutes = minutes % 60;
      return '${hours}h ${remainingMinutes}m';
    }
    return '$minutes min';
  }

  LatLng _interpolateLatLng(LatLng from, LatLng to, double factor) {
    return LatLng(
      from.latitude + ((to.latitude - from.latitude) * factor),
      from.longitude + ((to.longitude - from.longitude) * factor),
    );
  }

  double _interpolateBearing(double from, double to, double factor) {
    var diff = (to - from) % 360;
    if (diff > 180) diff -= 360;
    if (diff < -180) diff += 360;
    return (from + (diff * factor) + 360) % 360;
  }
}

String _stripHtml(String htmlString) {
  return htmlString
      .replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}

class _InstructionCard extends StatelessWidget {
  const _InstructionCard({
    required this.instruction,
    required this.distance,
    this.isArrival = false,
  });

  final String instruction;
  final String distance;
  final bool isArrival;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isArrival ? Colors.green.shade700 : Colors.black.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 15, offset: Offset(0, 5)),
        ],
      ),
      child: Row(
        children: [
          Icon(
            isArrival ? Icons.check_circle_rounded : Icons.directions_rounded,
            color: Colors.white,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  instruction,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (distance.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    distance,
                    style: GoogleFonts.inter(
                      color: Colors.white60,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Speedometer extends StatelessWidget {
  final double speed;
  final int? limit;

  const _Speedometer({
    required this.speed,
    this.limit,
  });

  @override
  Widget build(BuildContext context) {
    final speedInt = speed.round();
    final isOverLimit = limit != null && speedInt > limit!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (limit != null) ...[
          _SpeedLimitSign(limit: limit!),
          const SizedBox(width: 8),
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isOverLimit ? Colors.red.shade400 : Colors.white24,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: (isOverLimit ? Colors.red : Colors.black).withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '$speedInt',
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: isOverLimit ? Colors.red.shade100 : Colors.white,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'km/h',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isOverLimit ? Colors.red.shade200 : Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SpeedLimitSign extends StatelessWidget {
  final int limit;

  const _SpeedLimitSign({required this.limit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.red, width: 5),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Center(
        child: Text(
          '$limit',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
