class ChatMessage {
  const ChatMessage({required this.text, required this.fromUser, required this.createdAt});

  final String text;
  final bool fromUser;
  final DateTime createdAt;
}
