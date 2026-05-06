import '../intents/megan_intent.dart';

class IntentRouter {
  String route(MeganIntent intent) {
    switch (intent.type) {
      case MeganIntentType.openApp:
        return 'local_open_app';
      case MeganIntentType.sendWhatsApp:
        return 'local_send_whatsapp';
      case MeganIntentType.readNotifications:
        return 'local_read_notifications';
      case MeganIntentType.navigation:
        return 'local_navigation';
      case MeganIntentType.localTime:
        return 'local_time';
      case MeganIntentType.aiChat:
        return 'cloud_ai_chat';
      case MeganIntentType.unknown:
        return 'unknown';
    }
  }
}
