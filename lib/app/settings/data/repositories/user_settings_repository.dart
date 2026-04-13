import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../appearance/models/car_icon_model.dart';
import '../../../locale/models/app_locale_option_model.dart';
import '../datasources/user_settings_data_source.dart';
import '../../models/user_settings_model.dart';
import '../../../appearance/data/repositories/app_appearance_repository.dart';
import '../../../voice/data/repositories/app_voice_repository.dart';

abstract class UserSettingsRepository {
  Future<void> syncToCloud();
  Future<void> syncFromCloud();
  Map<String, dynamic>? getSettingsForBackup();
  Future<void> restoreFromBackup(Map<String, dynamic> data);
}

@LazySingleton(as: UserSettingsRepository)
class UserSettingsRepositoryImpl implements UserSettingsRepository {
  final UserSettingsDataSource _dataSource;
  final SupabaseClient _supabaseClient;
  final AppAppearanceRepository _appearanceRepository;
  final AppVoiceRepository _voiceRepository;

  UserSettingsRepositoryImpl(
    this._dataSource,
    this._supabaseClient,
    this._appearanceRepository,
    this._voiceRepository,
  );

  String? get _userId => _supabaseClient.auth.currentUser?.id;

  @override
  Future<void> syncToCloud() async {
    final userId = _userId;
    if (userId == null) return;

    final settings = _getCurrentSettings();
    await _dataSource.saveSettings(userId, settings);
  }

  @override
  Future<void> syncFromCloud() async {
    final userId = _userId;
    if (userId == null) return;

    final settings = await _dataSource.fetchSettings(userId);
    if (settings != null) {
      await _applySettings(settings);
    }
  }

  @override
  Map<String, dynamic>? getSettingsForBackup() {
    return _getCurrentSettings().toJson();
  }

  @override
  Future<void> restoreFromBackup(Map<String, dynamic> data) async {
    try {
      final settings = UserSettingsModel.fromJson(data);
      await _applySettings(settings);
      await syncToCloud();
    } catch (e) {
      // Ignore if backup has invalid settings format
    }
  }

  UserSettingsModel _getCurrentSettings() {
    return UserSettingsModel(
      locale: _appearanceRepository.currentLocale.storageValue,
      brightness: _appearanceRepository.currentBrightness,
      carIconIndex: _appearanceRepository.currentCarIcon.index,
      speechRate: _voiceRepository.currentSpeechRate,
      speechPitch: _voiceRepository.currentSpeechPitch,
    );
  }

  Future<void> _applySettings(UserSettingsModel settings) async {
    await _appearanceRepository.setLocale(AppLocaleOptionModel.fromStorageValue(settings.locale));
    await _appearanceRepository.setBrightness(settings.brightness);
    
    if (settings.carIconIndex >= 0 && settings.carIconIndex < CarIconType.values.length) {
      await _appearanceRepository.setCarIcon(CarIconType.values[settings.carIconIndex]);
    }
    
    await _voiceRepository.setSpeechRate(settings.speechRate);
    await _voiceRepository.setSpeechPitch(settings.speechPitch);
  }
}
