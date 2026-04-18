part of 'planning_cubit.dart';

@freezed
sealed class PlanningState with _$PlanningState {
  const factory PlanningState.initial() = Initial;
  const factory PlanningState.loading() = Loading;
  const factory PlanningState.loaded({
    @Default([]) List<AddressModel> allAddresses,
    @Default([]) List<String> selectedAddressIds,
    @Default([]) List<AddressModel> plannedAddresses,
    @Default(0) int currentIndex,
    String? errorKey,
  }) = Loaded;
}
