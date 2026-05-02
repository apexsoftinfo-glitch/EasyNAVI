part of 'app_voice_cubit.dart';

@freezed
abstract class AppVoiceState with _$AppVoiceState {
  const factory AppVoiceState.initial() = Initial;
  const factory AppVoiceState.loaded({
    @Default(AppVoiceRepository.defaultSpeechRate) double speechRate,
    @Default(AppVoiceRepository.defaultSpeechPitch) double speechPitch,
  }) = Loaded;
}
