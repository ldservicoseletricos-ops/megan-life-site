import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  TtsService() {
    _tts.setLanguage('pt-BR');
    _tts.setSpeechRate(0.48);
    _tts.setPitch(1.0);
  }

  final FlutterTts _tts = FlutterTts();

  Future<void> speak(String text) async {
    if (text.trim().isEmpty) return;
    await _tts.stop();
    await _tts.speak(text);
  }

  Future<void> stop() => _tts.stop();
}
