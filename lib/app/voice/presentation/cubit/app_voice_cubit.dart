import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../data/repositories/app_voice_repository.dart';

part 'app_voice_state.dart';
part 'app_voice_cubit.freezed.dart';

@lazySingleton
class AppVoiceCubit extends Cubit<AppVoiceState> {
  final AppVoiceRepository _repository;
  StreamSubscription? _rateSubscription;
  StreamSubscription? _pitchSubscription;

  AppVoiceCubit(this._repository) : super(const AppVoiceState.initial()) {
    _init();
  }

  void _init() {
    emit(AppVoiceState.loaded(
      speechRate: _repository.currentSpeechRate,
      speechPitch: _repository.currentSpeechPitch,
    ));

    _rateSubscription = _repository.speechRateStream.listen((rate) {
      final currentState = state;
      if (currentState is Loaded) {
        emit(currentState.copyWith(speechRate: rate));
      }
    });

    _pitchSubscription = _repository.speechPitchStream.listen((pitch) {
      final currentState = state;
      if (currentState is Loaded) {
        emit(currentState.copyWith(speechPitch: pitch));
      }
    });
  }

  Future<void> setSpeechRate(double rate) async {
    await _repository.setSpeechRate(rate);
  }

  Future<void> setSpeechPitch(double pitch) async {
    await _repository.setSpeechPitch(pitch);
  }

  @override
  Future<void> close() {
    _rateSubscription?.cancel();
    _pitchSubscription?.cancel();
    return super.close();
  }
}
