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

  DriveCubit(this._repository) : super(const DriveState.initial());

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
    } catch (e) {
      emit(const DriveState.error('unexpected-error'));
    }
  }
}
