import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

abstract class AppVoiceRepository {
  Stream<double> get speechRateStream;
  Stream<double> get speechPitchStream;
  
  Future<void> setSpeechRate(double rate);
  Future<void> setSpeechPitch(double pitch);
  
  double get currentSpeechRate;
  double get currentSpeechPitch;
}

@LazySingleton(as: AppVoiceRepository)
class AppVoiceRepositoryImpl implements AppVoiceRepository {
  final SharedPreferences _prefs;
  
  static const _rateKey = 'app_voice_speech_rate';
  static const _pitchKey = 'app_voice_speech_pitch';
  
  final _rateSubject = BehaviorSubject<double>.seeded(1.0);
  final _pitchSubject = BehaviorSubject<double>.seeded(1.0);

  AppVoiceRepositoryImpl(this._prefs) {
    _init();
  }

  void _init() {
    final rate = _prefs.getDouble(_rateKey) ?? 1.0;
    final pitch = _prefs.getDouble(_pitchKey) ?? 1.0;
    _rateSubject.add(rate);
    _pitchSubject.add(pitch);
  }

  @override
  Stream<double> get speechRateStream => _rateSubject.stream;

  @override
  Stream<double> get speechPitchStream => _pitchSubject.stream;

  @override
  double get currentSpeechRate => _rateSubject.value;

  @override
  double get currentSpeechPitch => _pitchSubject.value;

  @override
  Future<void> setSpeechRate(double rate) async {
    await _prefs.setDouble(_rateKey, rate);
    _rateSubject.add(rate);
  }

  @override
  Future<void> setSpeechPitch(double pitch) async {
    await _prefs.setDouble(_pitchKey, pitch);
    _pitchSubject.add(pitch);
  }
}
