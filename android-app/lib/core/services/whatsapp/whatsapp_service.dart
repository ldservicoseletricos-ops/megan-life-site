import 'package:url_launcher/url_launcher.dart';
import 'whatsapp_message_builder.dart';

class WhatsAppService {
  final WhatsAppMessageBuilder _builder = WhatsAppMessageBuilder();

  Future<bool> openWhatsAppForCommand(String command) async {
    final message = Uri.encodeComponent(_builder.extractMessage(command));
    final uri = Uri.parse('whatsapp://send?text=$message');
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
