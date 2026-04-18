part of 'drive_cubit.dart';

@freezed
sealed class DriveState with _$DriveState {
  const factory DriveState.initial() = Initial;
  const factory DriveState.loading() = Loading;
  const factory DriveState.loaded({
    required LatLng origin,
    required LatLng destination,
    required DirectionsModel directions,
    @Default(false) bool isNavigating,
    @Default(0) int currentStepIndex,
    LatLng? userPosition,
    @Default(0) double bearing,
    DateTime? startTime,
    @Default(0) double traveledDistance,
    @Default(0) double currentSpeed,
    @Default(0) double distanceToNextStep,
    int? currentSpeedLimit,
    @Default([]) List<LatLng> nearbyRadars,
    @Default([]) List<String> announcedRadarIds,
    @Default(false) bool isArrived,
  }) = Loaded;
  const factory DriveState.error(String errorKey) = DriveError;
}
