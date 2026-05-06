import '../brain/brain_context.dart';
import '../services/whatsapp/whatsapp_service.dart';
import 'megan_action.dart';

class SendWhatsAppAction implements MeganAction {
  SendWhatsAppAction(this._service);

  final WhatsAppService _service;

  @override
  Future<String> execute(String command, {BrainContext context = const BrainContext()}) async {
    final ok = await _service.openWhatsAppForCommand(command);
    return ok ? 'Abrindo o WhatsApp para enviar a mensagem.' : 'Não consegui preparar o WhatsApp agora.';
  }
}
