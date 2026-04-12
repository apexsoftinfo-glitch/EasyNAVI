import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
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
      child: DriveView(destinationName: destinationName),
    );
  }
}

class DriveView extends StatefulWidget {
  const DriveView({super.key, required this.destinationName});
  final String destinationName;

  @override
  State<DriveView> createState() => _DriveViewState();
}

class _DriveViewState extends State<DriveView> {


  Future<void> _startNavigation(LatLng destination) async {
    Uri url;
    if (Platform.isIOS) {
      url = Uri.parse('maps://?q=${destination.latitude},${destination.longitude}');
    } else {
      url = Uri.parse('google.navigation:q=${destination.latitude},${destination.longitude}');
    }

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // Fallback to browser
      final browserUrl = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=${destination.latitude},${destination.longitude}');
      await launchUrl(browserUrl, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<DriveCubit, DriveState>(
            builder: (context, state) {
              return switch (state) {
                Initial() || Loading() => const Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  ),
                Error(errorKey: final key) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(key, style: const TextStyle(color: Colors.red)),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<DriveCubit>().initDrive(destination: (state as dynamic).destination);
                          },
                          child: const Text('Ponów'),
                        ),
                      ],
                    ),
                  ),
                Loaded(origin: final origin, destination: final destination, directions: final directions) =>
                  GoogleMap(
                    onMapCreated: (controller) {
                      controller.animateCamera(
                        CameraUpdate.newLatLngBounds(
                          LatLngBounds(
                            southwest: directions.boundsSw,
                            northeast: directions.boundsNe,
                          ),
                          50,
                        ),
                      );
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
          
          // Back Button
          Positioned(
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
          ),

          // Bottom Info Panel
          BlocBuilder<DriveCubit, DriveState>(
            builder: (context, state) {
              if (state is! Loaded) return const SizedBox.shrink();
              
              final directions = state.directions;

              return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(24),
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
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'PODGLĄD KORKÓW',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: Colors.green.shade700,
                                letterSpacing: 0.5,
                              ),
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
                            _startNavigation(state.destination);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            elevation: 0,
                          ),
                          child: Text(
                            'START NAWIGACJI',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).padding.bottom),
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
