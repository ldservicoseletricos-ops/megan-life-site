import '../../core/models/installed_app.dart';
import '../../core/services/android/installed_apps_service.dart';

class AppRepository {
  AppRepository({InstalledAppsService? service}) : _service = service ?? InstalledAppsService();

  final InstalledAppsService _service;

  Future<List<InstalledApp>> all() => _service.getInstalledApps();
}
