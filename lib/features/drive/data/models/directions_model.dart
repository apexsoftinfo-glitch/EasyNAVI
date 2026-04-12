import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'directions_model.freezed.dart';

@freezed
abstract class RouteStepModel with _$RouteStepModel {
  const factory RouteStepModel({
    required LatLng startLocation,
    required String instruction, // e.g. "Turn right"
    required String distance, // e.g. "100m"
    required String maneuver, // e.g. "turn-right"
  }) = _RouteStepModel;
}

@freezed
abstract class DirectionsModel with _$DirectionsModel {
  const factory DirectionsModel({
    required LatLng boundsSw,
    required LatLng boundsNe,
    required List<LatLng> polylinePoints,
    required String totalDistance,
    required String totalDuration,
    required List<RouteStepModel> steps,
  }) = _DirectionsModel;
}
