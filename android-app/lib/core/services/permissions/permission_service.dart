import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<void> requestCorePermissions() async {
    await [
      Permission.microphone,
      Permission.notification,
      Permission.contacts,
      Permission.locationWhenInUse,
    ].request();
  }
}
