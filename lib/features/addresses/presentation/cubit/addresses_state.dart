part of 'addresses_cubit.dart';

@freezed
sealed class AddressesState with _$AddressesState {
  const factory AddressesState.initial() = Initial;
  const factory AddressesState.loading() = Loading;
  const factory AddressesState.loaded(List<AddressModel> addresses) = Loaded;
  const factory AddressesState.error(String errorKey) = Error;
}
