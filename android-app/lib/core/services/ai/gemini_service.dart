import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../brain/brain_context.dart';
import '../../config/app_config.dart';
import 'local_response_service.dart';

class GeminiService {
  GeminiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  final LocalResponseService _fallback = LocalResponseService();

  Future<String> sendMessage(String message, {BrainContext context = const BrainContext()}) async {
    try {
      final uri = Uri.parse('${AppConfig.apiUrl}/api/chat');
      final response = await _client
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'message': message, 'context': context.toJson()}),
          )
          .timeout(AppConfig.networkTimeout);

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return '${data['text'] ?? data['response'] ?? 'Não consegui responder agora.'}';
    } catch (_) {
      return _fallback.answer(message);
    }
  }
}
