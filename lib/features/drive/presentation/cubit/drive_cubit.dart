import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/directions_model.dart';
import '../../domain/repositories/directions_repository.dart';

part 'drive_state.dart';
part 'drive_cubit.freezed.dart';

@injectable
class DriveCubit extends Cubit<DriveState> {
  final DirectionsRepository _repository;
  StreamSubscription<Position>? _positionSubscription;

  DriveCubit(this._repository) : super(const DriveState.initial());

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    return super.close();
  }

  Future<void> initDrive({required LatLng destination}) async {
    emit(const DriveState.loading());

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(const DriveState.error('location-services-disabled'));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(const DriveState.error('location-permission-denied'));
          return;
        }
      }

      final position = await Geolocator.getCurrentPosition();
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

    emit(currentState.copyWith(isNavigating: true));
    
    _positionSubscription?.cancel();
    _positionSubscription = Geolocator.getPositionStream(
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
    emit(currentState.copyWith(isNavigating: false));
  }

  void _onPositionChanged(Position position) {
    final currentState = state;
    if (currentState is! Loaded) return;

    final userLatLng = LatLng(position.latitude, position.longitude);
    
    // Find closest step (basic implementation: check distance to next step)
    int nextStepIndex = currentState.currentStepIndex;
    if (nextStepIndex < currentState.directions.steps.length) {
      final step = currentState.directions.steps[nextStepIndex];
      final distance = Geolocator.distanceBetween(
        userLatLng.latitude, userLatLng.longitude,
        step.startLocation.latitude, step.startLocation.longitude,
      );
      
      // If we are close to the start of the next step, advance
      // This is simplified; professional navigation uses point-on-polyline logic
      if (distance < 20) {
        nextStepIndex++;
      }
    }

    emit(currentState.copyWith(
      userPosition: userLatLng,
      currentStepIndex: nextStepIndex,
    ));
  }
}
