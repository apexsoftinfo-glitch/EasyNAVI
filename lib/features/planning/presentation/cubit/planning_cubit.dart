import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import '../../../addresses/data/models/address_model.dart';
import '../../../addresses/domain/repositories/addresses_repository.dart';

part 'planning_state.dart';
part 'planning_cubit.freezed.dart';

enum PlanningMode {
  sequence,
  closest,
  farthest,
}

@injectable
class PlanningCubit extends Cubit<PlanningState> {
  final AddressesRepository _addressesRepository;

  PlanningCubit(this._addressesRepository) : super(const PlanningState.initial()) {
    _init();
  }

  void _init() {
    _addressesRepository.observeAddresses().listen((addresses) {
      if (state is! Loaded) {
        emit(PlanningState.loaded(allAddresses: addresses));
      } else {
        final currentLoaded = state as Loaded;
        emit(currentLoaded.copyWith(allAddresses: addresses));
      }
    });
  }

  void toggleSelection(AddressModel address) {
    if (state is! Loaded) return;
    final current = state as Loaded;
    final selectedIds = List<String>.from(current.selectedAddressIds);
    
    if (selectedIds.contains(address.id)) {
      selectedIds.remove(address.id);
    } else {
      selectedIds.add(address.id);
    }
    
    emit(current.copyWith(selectedAddressIds: selectedIds));
  }

  Future<void> planRoute(PlanningMode mode) async {
    if (state is! Loaded) return;
    final current = state as Loaded;
    if (current.selectedAddressIds.isEmpty) return;

    final selectedAddresses = current.selectedAddressIds
        .map((id) => current.allAddresses.firstWhere((a) => a.id == id))
        .toList();

    List<AddressModel> planned;

    switch (mode) {
      case PlanningMode.sequence:
        planned = selectedAddresses;
        break;
      case PlanningMode.closest:
        planned = await _sortClosest(selectedAddresses);
        break;
      case PlanningMode.farthest:
        planned = await _sortFarthest(selectedAddresses);
        break;
    }

    emit(current.copyWith(
      plannedAddresses: planned,
      currentIndex: 0,
    ));
  }

  Future<List<AddressModel>> _sortClosest(List<AddressModel> addresses) async {
    final position = await Geolocator.getCurrentPosition();
    final sorted = List<AddressModel>.from(addresses);
    
    // Simple greedy approach for "closest from current and then closest from previous"
    final result = <AddressModel>[];
    var currentLat = position.latitude;
    var currentLon = position.longitude;

    while (sorted.isNotEmpty) {
      sorted.sort((a, b) {
        final distA = Geolocator.distanceBetween(currentLat, currentLon, a.latitude ?? 0, a.longitude ?? 0);
        final distB = Geolocator.distanceBetween(currentLat, currentLon, b.latitude ?? 0, b.longitude ?? 0);
        return distA.compareTo(distB);
      });
      final closest = sorted.removeAt(0);
      result.add(closest);
      currentLat = closest.latitude ?? currentLat;
      currentLon = closest.longitude ?? currentLon;
    }

    return result;
  }

  Future<List<AddressModel>> _sortFarthest(List<AddressModel> addresses) async {
    final position = await Geolocator.getCurrentPosition();
    final sorted = List<AddressModel>.from(addresses);
    
    // Sort addresses by distance from current position descending
    sorted.sort((a, b) {
      final distA = Geolocator.distanceBetween(position.latitude, position.longitude, a.latitude ?? 0, a.longitude ?? 0);
      final distB = Geolocator.distanceBetween(position.latitude, position.longitude, b.latitude ?? 0, b.longitude ?? 0);
      return distB.compareTo(distA);
    });

    return sorted;
  }

  void nextDestination() {
    if (state is! Loaded) return;
    final current = state as Loaded;
    if (current.currentIndex < current.plannedAddresses.length - 1) {
      emit(current.copyWith(currentIndex: current.currentIndex + 1));
    }
  }

  void reset() {
    if (state is! Loaded) return;
    final current = state as Loaded;
    emit(current.copyWith(plannedAddresses: [], currentIndex: 0, selectedAddressIds: []));
  }
}
