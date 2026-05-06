import '../brain/brain_context.dart';
import '../services/ai/gemini_service.dart';
import 'megan_action.dart';

class AiChatAction implements MeganAction {
  AiChatAction(this._service);

  final GeminiService _service;

  @override
  Future<String> execute(String command, {BrainContext context = const BrainContext()}) {
    return _service.sendMessage(command, context: context);
  }
}
