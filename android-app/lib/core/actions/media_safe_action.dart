import '../brain/brain_context.dart';
import 'megan_action.dart';

class MediaSafeAction implements MeganAction {
  @override
  Future<String> execute(String command, {BrainContext context = const BrainContext()}) async {
    return context.mediaActive ? 'Modo seguro de mídia ativo.' : 'Mídia livre.';
  }
}
