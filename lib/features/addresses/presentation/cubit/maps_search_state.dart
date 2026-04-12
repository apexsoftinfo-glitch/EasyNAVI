part of 'maps_search_cubit.dart';

@freezed
sealed class MapsSearchState with _$MapsSearchState {
  const factory MapsSearchState.initial() = Initial;
  const factory MapsSearchState.loading() = LoadingPredictions;
  const factory MapsSearchState.loaded(List<PredictionModel> predictions) = LoadedPredictions;
  const factory MapsSearchState.selected(Map<String, String> details) = Selected;
  const factory MapsSearchState.error(String errorKey) = SearchError;
}
