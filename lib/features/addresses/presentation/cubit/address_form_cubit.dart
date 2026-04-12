import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/address_model.dart';
import '../../domain/repositories/addresses_repository.dart';

part 'address_form_state.dart';
part 'address_form_cubit.freezed.dart';

@injectable
class AddressFormCubit extends Cubit<AddressFormState> {
  final AddressesRepository _repository;
  final SupabaseClient _supabase;

  AddressFormCubit(this._repository, this._supabase) : super(const AddressFormState.initial());

  Future<void> saveAddress({
    required String name,
    required String street,
    required String city,
    required String zipCode,
    double? latitude,
    double? longitude,
    String? id,
  }) async {
    emit(const AddressFormState.loading());

    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      emit(const AddressFormState.error('session-expired'));
      return;
    }

    final address = AddressModel(
      id: id ?? '',
      userId: userId,
      name: name,
      street: street,
      city: city,
      zipCode: zipCode,
      latitude: latitude,
      longitude: longitude,
    );

    try {
      if (id == null) {
        await _repository.addAddress(address);
      } else {
        await _repository.updateAddress(address);
      }
      emit(const AddressFormState.success());
    } catch (e) {
      emit(const AddressFormState.error('failed-to-save'));
    }
  }
}
