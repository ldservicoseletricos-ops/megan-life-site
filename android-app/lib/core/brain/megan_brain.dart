import '../actions/ai_chat_action.dart';
import '../actions/megan_action.dart';
import '../actions/navigation_action.dart';
import '../actions/open_app_action.dart';
import '../actions/read_notifications_action.dart';
import '../actions/send_whatsapp_action.dart';
import '../services/ai/gemini_service.dart';
import '../services/android/app_launcher_service.dart';
import '../services/android/notification_bridge.dart';
import '../services/whatsapp/whatsapp_service.dart';
import 'action_planner.dart';
import 'brain_context.dart';
import 'brain_result.dart';
import 'execution_guard.dart';
import 'intent_detector.dart';
import 'intent_router.dart';

class MeganBrain {
  MeganBrain({
    IntentDetector? detector,
    IntentRouter? router,
    ActionPlanner? planner,
    ExecutionGuard? guard,
    GeminiService? geminiService,
    AppLauncherService? appLauncherService,
    NotificationBridge? notificationBridge,
    WhatsAppService? whatsAppService,
  })  : _detector = detector ?? IntentDetector(),
        _router = router ?? IntentRouter(),
        _planner = planner ?? ActionPlanner(),
        _guard = guard ?? ExecutionGuard(),
        _geminiService = geminiService ?? GeminiService(),
        _appLauncherService = appLauncherService ?? AppLauncherService(),
        _notificationBridge = notificationBridge ?? NotificationBridge(),
        _whatsAppService = whatsAppService ?? WhatsAppService();

  final IntentDetector _detector;
  final IntentRouter _router;
  final ActionPlanner _planner;
  final ExecutionGuard _guard;
  final GeminiService _geminiService;
  final AppLauncherService _appLauncherService;
  final NotificationBridge _notificationBridge;
  final WhatsAppService _whatsAppService;

  Future<BrainResult> decide(String command, {BrainContext context = const BrainContext()}) async {
    final intent = _detector.detect(command);
    final action = _router.route(intent);

    if (!_guard.canExecute(action, context)) {
      return BrainResult.local(
        intentType: intent.type.name,
        action: action,
        response: 'Não vou interromper sua mídia agora.',
        requiresAndroid: false,
      );
    }

    return BrainResult.local(
      intentType: intent.type.name,
      action: action,
      response: _planner.requiresAndroid(action) ? 'Vou executar isso no celular.' : 'Vou responder agora.',
      requiresAndroid: _planner.requiresAndroid(action),
    );
  }

  Future<String> execute(String command, {BrainContext context = const BrainContext()}) async {
    final result = await decide(command, context: context);
    final MeganAction action;

    switch (result.action) {
      case 'local_open_app':
        action = OpenAppAction(_appLauncherService);
        break;
      case 'local_send_whatsapp':
        action = SendWhatsAppAction(_whatsAppService);
        break;
      case 'local_read_notifications':
        action = ReadNotificationsAction(_notificationBridge);
        break;
      case 'local_navigation':
        action = NavigationAction(_appLauncherService);
        break;
      case 'local_time':
        return 'Agora são ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}.';
      case 'cloud_ai_chat':
      default:
        action = AiChatAction(_geminiService);
    }

    return action.execute(command, context: context);
  }
}
