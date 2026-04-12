part of 'address_form_cubit.dart';

@freezed
sealed class AddressFormState with _$AddressFormState {
  const factory AddressFormState.initial() = Initial;
  const factory AddressFormState.loading() = Loading;
  const factory AddressFormState.success() = Success;
  const factory AddressFormState.error(String errorKey) = Error;
}
