import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_state.freezed.dart';

@freezed
abstract class SyncState with _$SyncState {
  const factory SyncState.initial() = Initial;
  const factory SyncState.loading() = Loading;
  const factory SyncState.success(String message) = Success;
  const factory SyncState.error(String errorKey) = Error;
}
