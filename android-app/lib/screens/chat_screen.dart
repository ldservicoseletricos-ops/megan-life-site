import 'package:flutter/material.dart';
import '../core/models/chat_message.dart';
import '../core/brain/megan_brain.dart';
import '../ui/widgets/megan_chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final MeganBrain _brain = MeganBrain();
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    setState(() => _messages.add(ChatMessage(text: text, fromUser: true, createdAt: DateTime.now())));
    final response = await _brain.execute(text);
    setState(() => _messages.add(ChatMessage(text: response, fromUser: false, createdAt: DateTime.now())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Megan')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (_, index) => MeganChatBubble(message: _messages[index]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Mensagem para Megan'),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                IconButton(icon: const Icon(Icons.send), onPressed: _send),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
