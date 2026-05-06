import 'package:url_launcher/url_launcher.dart';
import '../../utils/text_normalizer.dart';

class AppLauncherService {
  Future<bool> openAppByName(String appName) async {
    final normalized = TextNormalizer.normalize(appName);

    if (normalized.contains('youtube') || normalized.contains('rvx')) {
      return launchUrl(Uri.parse('vnd.youtube://'), mode: LaunchMode.externalApplication);
    }
    if (normalized.contains('whatsapp') || normalized.contains('zap')) {
      return launchUrl(Uri.parse('whatsapp://send'), mode: LaunchMode.externalApplication);
    }
    if (normalized.contains('waze')) {
      return launchUrl(Uri.parse('waze://'), mode: LaunchMode.externalApplication);
    }
    if (normalized.contains('maps') || normalized.contains('mapa')) {
      return launchUrl(Uri.parse('geo:0,0'), mode: LaunchMode.externalApplication);
    }

    return false;
  }

  Future<bool> openNavigation(String command) async {
    final encoded = Uri.encodeComponent(command);
    final uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$encoded');
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
