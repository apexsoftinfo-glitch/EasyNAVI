import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:screen_brightness/screen_brightness.dart';

import '../../../locale/models/app_locale_option_model.dart';
import '../../models/car_icon_model.dart';

abstract class AppAppearanceRepository {
  Stream<AppLocaleOptionModel> get localeStream;
  AppLocaleOptionModel get currentLocale;
  Future<void> setLocale(AppLocaleOptionModel locale);

  Stream<double> get brightnessStream;
  double get currentBrightness;
  Future<void> setBrightness(double value);

  Stream<CarIconType> get carIconStream;
  CarIconType get currentCarIcon;
  Future<void> setCarIcon(CarIconType type);
  
  Future<void> init();
}

@LazySingleton(as: AppAppearanceRepository)
class AppAppearanceRepositoryImpl implements AppAppearanceRepository {
  final SharedPreferences _prefs;
  
  AppAppearanceRepositoryImpl(this._prefs)
    : _localeController = BehaviorSubject<AppLocaleOptionModel>.seeded(AppLocaleOptionModel.system),
      _brightnessController = BehaviorSubject<double>.seeded(0.5),
      _carIconController = BehaviorSubject<CarIconType>.seeded(CarIconType.classic);

  final BehaviorSubject<AppLocaleOptionModel> _localeController;
  final BehaviorSubject<double> _brightnessController;
  final BehaviorSubject<CarIconType> _carIconController;

  static const _keyLocale = 'appearance_locale';
  static const _keyBrightness = 'appearance_brightness';
  static const _keyCarIcon = 'appearance_car_icon';

  @override
  Future<void> init() async {
    try {
      // Init Locale
      final localeVal = _prefs.getString(_keyLocale);
      _localeController.add(AppLocaleOptionModel.fromStorageValue(localeVal));

      // Init Brightness
      double savedBrightness = 0.5;
      try {
        savedBrightness = await ScreenBrightness.instance.application;
      } catch (e) {
        debugPrint('⚠️ [AppAppearanceRepository] Could not get current brightness: $e');
      }
      
      final brightnessVal = _prefs.getDouble(_keyBrightness) ?? savedBrightness;
      _brightnessController.add(brightnessVal);
      
      // Apply saved brightness without blocking the main init flow
      ScreenBrightness.instance.setApplicationScreenBrightness(brightnessVal).catchError((e) {
        debugPrint('⚠️ [AppAppearanceRepository] Could not set brightness: $e');
      });

      // Init Car Icon
      final carIconIndex = _prefs.getInt(_keyCarIcon) ?? 0;
      if (carIconIndex < CarIconType.values.length) {
        _carIconController.add(CarIconType.values[carIconIndex]);
      }
    } catch (e) {
      debugPrint('❌ [AppAppearanceRepository] Global init error: $e');
    }
  }

  @override
  Stream<AppLocaleOptionModel> get localeStream => _localeController.stream.distinct();
  @override
  AppLocaleOptionModel get currentLocale => _localeController.value;

  @override
  Future<void> setLocale(AppLocaleOptionModel locale) async {
    await _prefs.setString(_keyLocale, locale.storageValue);
    _localeController.add(locale);
  }

  @override
  Stream<double> get brightnessStream => _brightnessController.stream.distinct();
  @override
  double get currentBrightness => _brightnessController.value;

  @override
  Future<void> setBrightness(double value) async {
    await _prefs.setDouble(_keyBrightness, value);
    await ScreenBrightness.instance.setApplicationScreenBrightness(value);
    _brightnessController.add(value);
  }

  @override
  Stream<CarIconType> get carIconStream => _carIconController.stream.distinct();
  @override
  CarIconType get currentCarIcon => _carIconController.value;

  @override
  Future<void> setCarIcon(CarIconType type) async {
    await _prefs.setInt(_keyCarIcon, type.index);
    _carIconController.add(type);
  }
}
