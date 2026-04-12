import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'directions_model.freezed.dart';

@freezed
abstract class DirectionsModel with _$DirectionsModel {
  const factory DirectionsModel({
    required LatLng boundsSw,
    required LatLng boundsNe,
    required List<LatLng> polylinePoints,
    required String totalDistance,
    required String totalDuration,
  }) = _DirectionsModel;
}
