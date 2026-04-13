import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/directions_model.dart';
import '../../domain/repositories/directions_repository.dart';
import '../../../../core/services/voice_navigation_service.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/services/device_service.dart';

part 'drive_state.dart';
part 'drive_cubit.freezed.dart';

@injectable
class DriveCubit extends Cubit<DriveState> {
  final DirectionsRepository _repository;
  final NavigationVoiceService _voiceService;
  final LocationService _locationService;
  final DeviceService _deviceService;
  StreamSubscription<Position>? _positionSubscription;
  DateTime? _lastSpeedLimitUpdate;
  LatLng? _lastSpeedLimitPosition;
  bool _isRerouting = false;
  DateTime? _lastRerouteCheck;
  String _language = 'en';

  DriveCubit(
    this._repository, 
    this._voiceService, 
    this._locationService,
    this._deviceService,
  ) : super(const DriveState.initial());

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    _voiceService.stop();
    _deviceService.disableWakelock(); // Extra safety on close
    return super.close();
  }

  Future<void> initDrive({required LatLng destination, String language = 'en'}) async {
    _language = language;
    emit(const DriveState.loading());

    try {
      bool serviceEnabled = await _locationService.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(const DriveState.error('location-services-disabled'));
        return;
      }

      LocationPermission permission = await _locationService.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await _locationService.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(const DriveState.error('location-permission-denied'));
          return;
        }
      }

      final position = await _locationService.getCurrentPosition();
      final origin = LatLng(position.latitude, position.longitude);

      final directions = await _repository.getDirections(
        origin: origin,
        destination: destination,
        language: _language,
      );

      if (directions != null) {
        emit(DriveState.loaded(
          origin: origin,
          destination: destination,
          directions: directions,
          userPosition: origin,
        ));
        
        // Start tracking position even before "Go" to show speed limits in preview
        _startTracking();
        _updateEnvironmentalData(origin);
      } else {
        emit(const DriveState.error('failed-to-calculate-route'));
      }
    } catch (e, stack) {
      debugPrint('[DriveCubit] Error: $e');
      debugPrint('[DriveCubit] Stack: $stack');
      emit(const DriveState.error('unexpected-error'));
    }
  }

  void startNavigation() {
    final currentState = state;
    if (currentState is! Loaded) return;

    double initialDistance = 0;
    if (currentState.userPosition != null && currentState.directions.steps.isNotEmpty) {
      if (currentState.directions.steps.length > 1) {
        final nextStep = currentState.directions.steps[1];
        initialDistance = Geolocator.distanceBetween(
          currentState.userPosition!.latitude, currentState.userPosition!.longitude,
          nextStep.startLocation.latitude, nextStep.startLocation.longitude,
        );
      } else {
        initialDistance = Geolocator.distanceBetween(
          currentState.userPosition!.latitude, currentState.userPosition!.longitude,
          currentState.destination.latitude, currentState.destination.longitude,
        );
      }
    }

    emit(currentState.copyWith(
      isNavigating: true,
      startTime: DateTime.now(),
      traveledDistance: 0,
      distanceToNextStep: initialDistance,
    ));

    // Ensure tracking is active
    _startTracking();
    
    // Speak first instruction
    if (currentState.directions.steps.isNotEmpty) {
      _voiceService.speak(currentState.directions.steps[0].instruction);
    }
    
    // Keep screen on during navigation
    _deviceService.enableWakelock();
  }

  void _startTracking() {
    _positionSubscription?.cancel();
    _positionSubscription = _locationService.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen(_onPositionChanged);
  }

  void stopNavigation() {
    final currentState = state;
    if (currentState is! Loaded) return;

    _positionSubscription?.cancel();
    _voiceService.stop();
    _deviceService.disableWakelock();
    emit(currentState.copyWith(isNavigating: false));
  }

  void _onPositionChanged(Position position) {
    if (isClosed) return;
    final currentState = state;
    if (currentState is! Loaded) return;

    final userLatLng = LatLng(position.latitude, position.longitude);
    
    int nextStepIndex = currentState.currentStepIndex;
    double distanceToNextStep = 0;

    if (nextStepIndex < currentState.directions.steps.length - 1) {
      final nextStep = currentState.directions.steps[nextStepIndex + 1];
      distanceToNextStep = Geolocator.distanceBetween(
        userLatLng.latitude, userLatLng.longitude,
        nextStep.startLocation.latitude, nextStep.startLocation.longitude,
      );

      // If we are within 30m of the next turn, increment index
      if (distanceToNextStep < 30) {
        nextStepIndex++;
        if (nextStepIndex < currentState.directions.steps.length) {
          _voiceService.speak(currentState.directions.steps[nextStepIndex].instruction);
        }
        
        // Recalculate distance for the new current step's end
        if (nextStepIndex < currentState.directions.steps.length - 1) {
          final newerNextStep = currentState.directions.steps[nextStepIndex + 1];
          distanceToNextStep = Geolocator.distanceBetween(
            userLatLng.latitude, userLatLng.longitude,
            newerNextStep.startLocation.latitude, newerNextStep.startLocation.longitude,
          );
        } else {
          distanceToNextStep = Geolocator.distanceBetween(
            userLatLng.latitude, userLatLng.longitude,
            currentState.destination.latitude, currentState.destination.longitude,
          );
        }
      }
    } else if (nextStepIndex == currentState.directions.steps.length - 1) {
      // Last step: distance to destination
      distanceToNextStep = Geolocator.distanceBetween(
        userLatLng.latitude, userLatLng.longitude,
        currentState.destination.latitude, currentState.destination.longitude,
      );
    }

    double additionalDistance = 0;
    if (currentState.userPosition != null) {
      if (position.speed > 0.8 && position.accuracy < 25) {
        additionalDistance = Geolocator.distanceBetween(
          currentState.userPosition!.latitude,
          currentState.userPosition!.longitude,
          userLatLng.latitude,
          userLatLng.longitude,
        );
      }
    }

    double currentBearing = currentState.bearing;
    double newBearing = position.heading;
    
    // Only update bearing if moving significantly (avoid jitter at standstill)
    if (position.speed < 0.5) {
      newBearing = currentBearing;
    } else {
      // Basic angular interpolation/smoothing
      // To handle 359 -> 1 transition correctly:
      double diff = newBearing - currentBearing;
      while (diff < -180) {
        diff += 360;
      }
      while (diff > 180) {
        diff -= 360;
      }
      newBearing = currentBearing + (diff * 0.3); // 0.3 smoothing factor
    }

    emit(currentState.copyWith(
      userPosition: userLatLng,
      currentStepIndex: nextStepIndex,
      distanceToNextStep: distanceToNextStep,
      bearing: newBearing,
      traveledDistance: currentState.traveledDistance + additionalDistance,
      currentSpeed: position.speed * 3.6, // Convert m/s to km/h
    ));

    final now = DateTime.now();
    final shouldUpdateLimit = _lastSpeedLimitUpdate == null ||
        now.difference(_lastSpeedLimitUpdate!).inSeconds > 30 ||
        (_lastSpeedLimitPosition != null &&
            Geolocator.distanceBetween(
                  _lastSpeedLimitPosition!.latitude,
                  _lastSpeedLimitPosition!.longitude,
                  userLatLng.latitude,
                  userLatLng.longitude,
                ) >
                50);

    if (shouldUpdateLimit) {
      _lastSpeedLimitUpdate = now;
      _lastSpeedLimitPosition = userLatLng;
      _updateEnvironmentalData(userLatLng);
    }

    // Check for rerouting if navigating
    if (currentState.isNavigating) {
      final shouldCheckReroute = _lastRerouteCheck == null || 
          now.difference(_lastRerouteCheck!).inSeconds > 5;
      
      if (shouldCheckReroute) {
        _lastRerouteCheck = now;
        _checkReroute(userLatLng, currentState);
      }
    }

    for (final radar in currentState.nearbyRadars) {
      final radarId = "${radar.latitude}_${radar.longitude}";
      if (currentState.announcedRadarIds.contains(radarId)) continue;

      final distToRadar = Geolocator.distanceBetween(
        userLatLng.latitude,
        userLatLng.longitude,
        radar.latitude,
        radar.longitude,
      );

      if (distToRadar < 300) {
        final alert = _language == 'pl' 
            ? "Uwaga, fotoradar za trzysta metrów!" 
            : "Caution, speed camera in three hundred meters!";
        _voiceService.speak(alert);
        final updatedState = state as Loaded;
        emit(updatedState.copyWith(
          announcedRadarIds: [...updatedState.announcedRadarIds, radarId],
        ));
      }
    }
  }

  Future<void> _updateEnvironmentalData(LatLng position) async {
    final limit = await _repository.getSpeedLimit(position);
    final radars = await _repository.getNearbyRadars(position);
    if (isClosed) return;
    
    final currentState = state;
    if (currentState is Loaded) {
      emit(currentState.copyWith(
        currentSpeedLimit: limit,
        nearbyRadars: radars,
      ));
    }
  }

  Future<void> _checkReroute(LatLng userLatLng, Loaded currentState) async {
    if (_isRerouting || !currentState.isNavigating) return;

    // Check distance to polyline
    double minDistance = double.infinity;
    for (final point in currentState.directions.polylinePoints) {
      final d = Geolocator.distanceBetween(
        userLatLng.latitude,
        userLatLng.longitude,
        point.latitude,
        point.longitude,
      );
      if (d < minDistance) minDistance = d;
      // If we are close enough to any point, we are on track
      if (minDistance < 50) return;
    }

    // Off track! (> 50m from any point)
    _isRerouting = true;
    debugPrint('[DriveCubit] User off track (dist: $minDistance). Rerouting...');
    
    try {
      final directions = await _repository.getDirections(
        origin: userLatLng,
        destination: currentState.destination,
        language: _language,
      );

      if (directions != null && !isClosed) {
        final alert = _language == 'pl' ? "Przeliczam trasę" : "Recalculating route";
        _voiceService.speak(alert);
        emit(currentState.copyWith(
          directions: directions,
          currentStepIndex: 0,
        ));
        
        if (directions.steps.isNotEmpty) {
          _voiceService.speak(directions.steps[0].instruction);
        }
      }
    } catch (e) {
      debugPrint('[DriveCubit] Reroute failed: $e');
    } finally {
      _isRerouting = false;
    }
  }
}
