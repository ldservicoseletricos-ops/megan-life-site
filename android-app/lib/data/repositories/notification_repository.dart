import '../../core/models/notification_item.dart';
import '../../core/services/android/notification_bridge.dart';

class NotificationRepository {
  NotificationRepository({NotificationBridge? bridge}) : _bridge = bridge ?? NotificationBridge();

  final NotificationBridge _bridge;

  Future<List<NotificationItem>> latest() => _bridge.readLatestNotifications();
}
