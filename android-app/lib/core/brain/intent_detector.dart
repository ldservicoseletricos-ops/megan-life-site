import '../intents/megan_intent.dart';
import '../utils/text_normalizer.dart';

class IntentDetector {
  MeganIntent detect(String command) {
    final text = TextNormalizer.normalize(command);

    if (text.contains(RegExp(r'\b(abrir|abra|abre)\b'))) {
      return const MeganIntent(type: MeganIntentType.openApp, confidence: 0.92);
    }
    if (text.contains('whatsapp') || text.contains('zap') || text.contains('mensagem')) {
      return const MeganIntent(type: MeganIntentType.sendWhatsApp, confidence: 0.88);
    }
    if (text.contains('notificacao') || text.contains('notificacoes') || text.contains('leia')) {
      return const MeganIntent(type: MeganIntentType.readNotifications, confidence: 0.84);
    }
    if (text.contains('waze') || text.contains('maps') || text.contains('rota')) {
      return const MeganIntent(type: MeganIntentType.navigation, confidence: 0.82);
    }
    if (text.contains('que horas') || text.contains('hora atual')) {
      return const MeganIntent(type: MeganIntentType.localTime, confidence: 0.95);
    }
    return const MeganIntent(type: MeganIntentType.aiChat, confidence: 0.65);
  }
}
