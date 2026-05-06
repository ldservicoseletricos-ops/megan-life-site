import 'package:speech_to_text/speech_to_text.dart';

class SpeechListenerService {
  final SpeechToText _speech = SpeechToText();

  Future<bool> initialize() => _speech.initialize();

  Future<void> listen(void Function(String text) onText) async {
    final available = await initialize();
    if (!available) return;
    await _speech.listen(
      localeId: 'pt_BR',
      onResult: (result) {
        if (result.finalResult) onText(result.recognizedWords);
      },
    );
  }

  Future<void> stop() => _speech.stop();
}
