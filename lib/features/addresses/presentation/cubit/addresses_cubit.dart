import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/address_model.dart';
import '../../domain/repositories/addresses_repository.dart';

part 'addresses_state.dart';
part 'addresses_cubit.freezed.dart';

@injectable
class AddressesCubit extends Cubit<AddressesState> {
  final AddressesRepository _repository;
  StreamSubscription? _subscription;

  AddressesCubit(this._repository) : super(const AddressesState.initial()) {
    _init();
  }

  void _init() {
    emit(const AddressesState.loading());
    _subscription = _repository.observeAddresses().listen(
      (addresses) {
        emit(AddressesState.loaded(addresses));
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
      // Błędy krytyczne obsłużone przez repository, ale możemy emitować state jeśli potrzeba
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
