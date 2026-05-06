import '../brain/brain_context.dart';
import '../services/android/app_launcher_service.dart';
import '../utils/command_cleaner.dart';
import 'megan_action.dart';

class OpenAppAction implements MeganAction {
  OpenAppAction(this._launcher);

  final AppLauncherService _launcher;

  @override
  Future<String> execute(String command, {BrainContext context = const BrainContext()}) async {
    final appName = CommandCleaner.extractAppName(command);
    final opened = await _launcher.openAppByName(appName);
    return opened ? 'Abrindo $appName.' : 'Não consegui abrir $appName ainda.';
  }
}
