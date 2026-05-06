import '../../core/services/ai/gemini_service.dart';

class ChatRepository {
  ChatRepository({GeminiService? service}) : _service = service ?? GeminiService();

  final GeminiService _service;

  Future<String> send(String text) => _service.sendMessage(text);
}
