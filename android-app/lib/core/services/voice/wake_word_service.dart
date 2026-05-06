import '../../config/megan_constants.dart';
import '../../utils/text_normalizer.dart';

class WakeWordService {
  bool hasWakeWord(String text) {
    final normalized = TextNormalizer.normalize(text);
    return MeganConstants.wakeWords.any(normalized.contains);
  }
}
