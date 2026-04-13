import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/address_model.dart';
import '../../domain/repositories/addresses_repository.dart';
import '../../domain/repositories/maps_repository.dart';

part 'addresses_state.dart';
part 'addresses_cubit.freezed.dart';

@injectable
class AddressesCubit extends Cubit<AddressesState> {
  final AddressesRepository _repository;
  final MapsRepository _mapsRepository;
  StreamSubscription? _subscription;

  AddressesCubit(this._repository, this._mapsRepository) : super(const AddressesState.initial()) {
    _init();
  }

  // ... (previous methods)

  Future<AddressModel?> resolveCoordinates(AddressModel address) async {
    if (address.latitude != null && address.longitude != null) return address;

    try {
      final query = '${address.street}, ${address.city}, ${address.zipCode}';
      final coords = await _mapsRepository.geocodeAddress(query);

      if (coords != null) {
        final updated = address.copyWith(
          latitude: coords['lat'],
          longitude: coords['lng'],
        );
        await _repository.updateAddress(updated);
        return updated;
      }
    } catch (e) {
      // We ignore errors, just return null or original
    }
    return null;
  }

  void setSearchQuery(String query) {
    final currentState = state;
    if (currentState is Loaded) {
      emit(currentState.copyWith(searchQuery: query));
    }
  }

  void _init() {
    emit(const AddressesState.loading());
    _subscription = _repository.observeAddresses().listen(
      (addresses) {
        if (isClosed) return;
        final currentState = state;
        if (currentState is Loaded) {
          emit(currentState.copyWith(addresses: addresses));
        } else {
          emit(AddressesState.loaded(addresses));
        }
      },
      onError: (error) {
        emit(const AddressesState.error('failed-to-load-addresses'));
      },
    );
  }

  Future<void> retry() async {
    _subscription?.cancel();
    _init();
  }

  Future<void> deleteAddress(String id) async {
    try {
      await _repository.deleteAddress(id);
    } catch (e) {
      // Critical errors are handled by repository, but we can emit state if needed
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
