import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../locale/models/app_locale_option_model.dart';
import '../../models/car_icon_model.dart';
import '../../data/repositories/app_appearance_repository.dart';
import '../../../settings/data/repositories/user_settings_repository.dart';

part 'app_appearance_cubit.freezed.dart';

@freezed
abstract class AppAppearanceState with _$AppAppearanceState {
  const AppAppearanceState._();

  const factory AppAppearanceState({
    required AppLocaleOptionModel selectedLocale,
    required double brightness,
    required CarIconType carIcon,
    @Default(false) bool isSaving,
  }) = _AppAppearanceState;

  Locale? get localeOrNull => selectedLocale.localeOrNull;
}

@singleton // Singleton to ensure we initialize once and hold state
class AppAppearanceCubit extends Cubit<AppAppearanceState> {
  AppAppearanceCubit(this._repository, this._settingsRepository)
    : super(AppAppearanceState(
        selectedLocale: _repository.currentLocale,
        brightness: _repository.currentBrightness,
        carIcon: _repository.currentCarIcon,
      )) {
    _init();
  }

  final AppAppearanceRepository _repository;
  final UserSettingsRepository _settingsRepository;
  StreamSubscription? _localeSub;
  StreamSubscription? _brightnessSub;
  StreamSubscription? _carIconSub;

  Future<void> _init() async {
    await _repository.init();
    if (isClosed) return;
    
    _localeSub = _repository.localeStream.listen((l) {
      if (!isClosed) emit(state.copyWith(selectedLocale: l));
    });
    _brightnessSub = _repository.brightnessStream.listen((b) {
      if (!isClosed) emit(state.copyWith(brightness: b));
    });
    _carIconSub = _repository.carIconStream.listen((c) {
      if (!isClosed) emit(state.copyWith(carIcon: c));
    });
  }

  Future<void> setLocale(AppLocaleOptionModel locale) async {
    await _repository.setLocale(locale);
    await _settingsRepository.syncToCloud();
  }

  Future<void> setBrightness(double value) async {
    await _repository.setBrightness(value);
    await _settingsRepository.syncToCloud();
  }

  Future<void> setCarIcon(CarIconType type) async {
    await _repository.setCarIcon(type);
    await _settingsRepository.syncToCloud();
  }

  @override
  Future<void> close() {
    _localeSub?.cancel();
    _brightnessSub?.cancel();
    _carIconSub?.cancel();
    return super.close();
  }
}
