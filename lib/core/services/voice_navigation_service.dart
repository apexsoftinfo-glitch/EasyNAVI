import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';
import '../../app/voice/data/repositories/app_voice_repository.dart';

@lazySingleton
class NavigationVoiceService {
  final FlutterTts _tts = FlutterTts();
  final AppVoiceRepository _voiceRepository;
  bool _isInitialized = false;

  NavigationVoiceService(this._voiceRepository);

  Future<void> init() async {
    if (_isInitialized) return;
    
    await _tts.setLanguage("pl-PL");
    await _tts.setSpeechRate(_voiceRepository.currentSpeechRate);
    await _tts.setVolume(1.0);
    await _tts.setPitch(_voiceRepository.currentSpeechPitch);
    
    // Listen for changes
    _voiceRepository.speechRateStream.listen((rate) => _tts.setSpeechRate(rate));
    _voiceRepository.speechPitchStream.listen((pitch) => _tts.setPitch(pitch));
    
    // Zapobiega wyciszaniu mowy przez przełącznik boczny iPhone'a
    await _tts.setIosAudioCategory(
      IosTextToSpeechAudioCategory.playback,
      [
        IosTextToSpeechAudioCategoryOptions.allowBluetooth,
        IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        IosTextToSpeechAudioCategoryOptions.mixWithOthers,
      ],
    );
    
    _isInitialized = true;
  }

  Future<void> speak(String text) async {
    debugPrint('🎙️ [NavigationVoiceService] Attempting to speak: $text');
    if (!_isInitialized) {
      debugPrint('🎙️ [NavigationVoiceService] Initializing first...');
      await init();
    }
    final cleanText = _stripHtml(text);
    debugPrint('🎙️ [NavigationVoiceService] Speaking clean text: $cleanText');
    
    // Refresh settings before speaking to be absolute sure
    await _tts.setSpeechRate(_voiceRepository.currentSpeechRate);
    await _tts.setPitch(_voiceRepository.currentSpeechPitch);
    
    final result = await _tts.speak(cleanText);
    debugPrint('🎙️ [NavigationVoiceService] Result: $result');
  }

  String _stripHtml(String htmlString) {
    return htmlString.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ').replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  Future<void> stop() async {
    await _tts.stop();
  }
}
