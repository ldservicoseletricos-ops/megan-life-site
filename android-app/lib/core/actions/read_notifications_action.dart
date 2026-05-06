import '../brain/brain_context.dart';
import '../services/android/notification_bridge.dart';
import 'megan_action.dart';

class ReadNotificationsAction implements MeganAction {
  ReadNotificationsAction(this._bridge);

  final NotificationBridge _bridge;

  @override
  Future<String> execute(String command, {BrainContext context = const BrainContext()}) async {
    final notifications = await _bridge.readLatestNotifications();
    if (notifications.isEmpty) return 'Não encontrei notificações recentes.';
    return notifications.take(3).map((item) => '${item.appName}: ${item.title} ${item.text}').join('. ');
  }
}
