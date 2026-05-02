import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

abstract class AppVoiceRepository {
  static const defaultSpeechRate = 0.45;
  static const defaultSpeechPitch = 1.025;

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

  final _rateSubject = BehaviorSubject<double>.seeded(
    AppVoiceRepository.defaultSpeechRate,
  );
  final _pitchSubject = BehaviorSubject<double>.seeded(
    AppVoiceRepository.defaultSpeechPitch,
  );

  AppVoiceRepositoryImpl(this._prefs) {
    _init();
  }

  void _init() {
    final rate =
        _prefs.getDouble(_rateKey) ?? AppVoiceRepository.defaultSpeechRate;
    final pitch =
        _prefs.getDouble(_pitchKey) ?? AppVoiceRepository.defaultSpeechPitch;
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
