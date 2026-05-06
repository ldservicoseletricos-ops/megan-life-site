import 'package:permission_handler/permission_handler.dart';

class PermissionChecker {
  Future<bool> get microphoneGranted async => Permission.microphone.isGranted;
  Future<bool> get notificationGranted async => Permission.notification.isGranted;
}
