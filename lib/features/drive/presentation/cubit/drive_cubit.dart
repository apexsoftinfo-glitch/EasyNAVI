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

  Future<void> initDrive({required LatLng destination}) async {
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
      );

      if (directions != null) {
        emit(DriveState.loaded(
          origin: origin,
          destination: destination,
          directions: directions,
        ));
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

    emit(currentState.copyWith(
      isNavigating: true,
      startTime: DateTime.now(),
      traveledDistance: 0,
    ));
    
    // Speak first instruction
    if (currentState.directions.steps.isNotEmpty) {
      _voiceService.speak(currentState.directions.steps[0].instruction);
    }
    
    // Keep screen on during navigation
    _deviceService.enableWakelock();

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
    if (nextStepIndex < currentState.directions.steps.length) {
      final step = currentState.directions.steps[nextStepIndex];
      final distance = Geolocator.distanceBetween(
        userLatLng.latitude, userLatLng.longitude,
        step.startLocation.latitude, step.startLocation.longitude,
      );
      
      if (distance < 20) {
        nextStepIndex++;
        
        if (nextStepIndex < currentState.directions.steps.length) {
          _voiceService.speak(currentState.directions.steps[nextStepIndex].instruction);
        }
      }
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
        _voiceService.speak("Uwaga, fotoradar za trzysta metrów!");
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
      if (minDistance < 15) return;
    }

    // Off track! (> 15m from any point)
    _isRerouting = true;
    debugPrint('[DriveCubit] User off track (dist: $minDistance). Rerouting...');
    
    try {
      final directions = await _repository.getDirections(
        origin: userLatLng,
        destination: currentState.destination,
      );

      if (directions != null && !isClosed) {
        _voiceService.speak("Przeliczam trasę");
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
