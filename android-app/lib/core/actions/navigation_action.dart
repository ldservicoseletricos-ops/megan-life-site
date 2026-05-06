import '../brain/brain_context.dart';
import '../services/android/app_launcher_service.dart';
import 'megan_action.dart';

class NavigationAction implements MeganAction {
  NavigationAction(this._launcher);

  final AppLauncherService _launcher;

  @override
  Future<String> execute(String command, {BrainContext context = const BrainContext()}) async {
    final opened = await _launcher.openNavigation(command);
    return opened ? 'Abrindo navegação.' : 'Não consegui abrir a navegação agora.';
  }
}
