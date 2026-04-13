part of 'app_voice_cubit.dart';

@freezed
abstract class AppVoiceState with _$AppVoiceState {
  const factory AppVoiceState.initial() = Initial;
  const factory AppVoiceState.loaded({
    @Default(1.0) double speechRate,
    @Default(1.0) double speechPitch,
  }) = Loaded;
}
