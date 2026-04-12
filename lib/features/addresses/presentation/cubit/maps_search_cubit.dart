import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/prediction_model.dart';
import '../../domain/repositories/maps_repository.dart';

part 'maps_search_state.dart';
part 'maps_search_cubit.freezed.dart';

@injectable
class MapsSearchCubit extends Cubit<MapsSearchState> {
  final MapsRepository _repository;
  String _sessionToken = const Uuid().v4();
  Timer? _debounce;

  MapsSearchCubit(this._repository) : super(const MapsSearchState.initial());

  void onInputChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    
    if (query.length < 3) {
      emit(const MapsSearchState.initial());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(const MapsSearchState.loading());
      try {
        final predictions = await _repository.getPredictions(query, _sessionToken);
        emit(MapsSearchState.loaded(predictions));
      } catch (e) {
        emit(const MapsSearchState.error('failed-to-search-maps'));
      }
    });
  }

  Future<void> selectPrediction(PredictionModel prediction) async {
    emit(const MapsSearchState.loading());
    try {
      final details = await _repository.getPlaceDetails(prediction.placeId);
      emit(MapsSearchState.selected(details));
      // Refresh token for next session
      _sessionToken = const Uuid().v4();
    } catch (e) {
      emit(const MapsSearchState.error('failed-to-get-details'));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
