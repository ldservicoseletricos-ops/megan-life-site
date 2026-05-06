import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _speech = SpeechToText();

  bool _ready = false;
  bool _finalDelivered = false;

  bool get isListening => _speech.isListening;
  bool get isReady => _ready;

  Future<bool> initialize() async {
    if (_ready) return true;

    _ready = await _speech.initialize(
      onError: (_) {},
      onStatus: (_) {},
    );

    return _ready;
  }

  Future<void> startListening({
    required void Function(String text) onPartialResult,
    required void Function(String text) onFinalResult,
  }) async {
    final ready = await initialize();
    if (!ready || _speech.isListening) return;

    _finalDelivered = false;

    await _speech.listen(
      localeId: 'pt_BR',
      partialResults: true,
      listenMode: ListenMode.confirmation,
      onResult: (result) {
        final text = result.recognizedWords.trim();
        if (text.isEmpty) return;

        if (result.finalResult && !_finalDelivered) {
          _finalDelivered = true;
          onFinalResult(text);
          return;
        }

        onPartialResult(text);
      },
    );
  }

  Future<void> stopListening() async {
    if (_speech.isListening) {
      await _speech.stop();
    }
  }

  Future<void> cancelListening() async {
    await _speech.cancel();
  }
}
