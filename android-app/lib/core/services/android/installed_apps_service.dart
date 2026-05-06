import '../../models/installed_app.dart';

class InstalledAppsService {
  Future<List<InstalledApp>> getInstalledApps() async {
    return const [
      InstalledApp(name: 'YouTube', packageName: 'com.google.android.youtube'),
      InstalledApp(name: 'WhatsApp', packageName: 'com.whatsapp'),
      InstalledApp(name: 'Waze', packageName: 'com.waze'),
      InstalledApp(name: 'Maps', packageName: 'com.google.android.apps.maps'),
    ];
  }
}
