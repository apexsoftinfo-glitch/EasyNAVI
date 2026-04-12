import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/di/injection.dart';
import '../presentation/cubit/drive_cubit.dart';

class DriveScreen extends StatelessWidget {
  const DriveScreen({super.key, required this.destination, required this.destinationName});
  final LatLng destination;
  final String destinationName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DriveCubit>()..initDrive(destination: destination),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocConsumer<DriveCubit, DriveState>(
            listener: (context, state) {
              if (state is Loaded && state.isNavigating && state.userPosition != null && _mapController != null) {
                _mapController!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: state.userPosition!,
                      zoom: 18,
                      tilt: 45,
                      bearing: 0, // In real app we would calculate bearing from movement
                    ),
                  ),
                );
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
                          child: const Text('Ponów'),
                        ),
                      ],
                    ),
                  ),
                Loaded(origin: final origin, destination: final destination, directions: final directions) =>
                  GoogleMap(
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
                    myLocationEnabled: true,
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
                    },
                    polylines: {
                      Polyline(
                        polylineId: const PolylineId('route'),
                        points: directions.polylinePoints,
                        color: Colors.blue.shade700,
                        width: 5,
                      ),
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
                    instruction: 'Jesteś u celu!',
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
                  instruction: step.instruction,
                  distance: step.distance,
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

              return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.fromLTRB(24, 24, 24, isNavigating ? 16 : 24),
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
                      if (!isNavigating) ...[
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
                      ],
                      SizedBox(
                        width: double.infinity,
                        height: 64,
                        child: ElevatedButton(
                          onPressed: () {
                            HapticFeedback.mediumImpact();
                            if (isNavigating) {
                              context.read<DriveCubit>().stopNavigation();
                            } else {
                              context.read<DriveCubit>().startNavigation();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isNavigating ? Colors.red.shade600 : Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            elevation: 0,
                          ),
                          child: Text(
                            isNavigating ? 'ZAKOŃCZ' : 'START NAWIGACJI',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: isNavigating ? 16 : MediaQuery.of(context).padding.bottom),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
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
