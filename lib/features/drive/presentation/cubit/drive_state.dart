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
  }) = Loaded;
  const factory DriveState.error(String errorKey) = DriveError;
}
