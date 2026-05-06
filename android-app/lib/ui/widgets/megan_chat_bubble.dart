import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MeganChatBubble extends StatelessWidget {
  MeganChatBubble({
    super.key,
    String? text,
    dynamic message,
    bool? isUser,
  })  : text = _resolveText(text: text, message: message),
        isUser = isUser ?? _resolveIsUser(message);

  final String text;
  final bool isUser;

  static String _resolveText({String? text, dynamic message}) {
    if (text != null) return text;

    if (message == null) return '';

    if (message is String) return message;

    try {
      final value = message.text;
      if (value != null) return value.toString();
    } catch (_) {}

    try {
      final value = message.content;
      if (value != null) return value.toString();
    } catch (_) {}

    try {
      final value = message.message;
      if (value != null) return value.toString();
    } catch (_) {}

    try {
      final value = message.body;
      if (value != null) return value.toString();
    } catch (_) {}

    return message.toString();
  }

  static bool _resolveIsUser(dynamic message) {
    if (message == null) return false;

    try {
      final value = message.isUser;
      if (value is bool) return value;
    } catch (_) {}

    try {
      final value = message.fromUser;
      if (value is bool) return value;
    } catch (_) {}

    try {
      final value = message.role;
      if (value != null) {
        final role = value.toString().toLowerCase().trim();
        return role == 'user' || role == 'usuario' || role == 'usuário';
      }
    } catch (_) {}

    try {
      final value = message.sender;
      if (value != null) {
        final sender = value.toString().toLowerCase().trim();
        return sender == 'user' || sender == 'usuario' || sender == 'usuário' || sender == 'luiz';
      }
    } catch (_) {}

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;

    return Align(
      alignment: alignment,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 320),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          gradient: isUser
              ? AppColors.premiumGradient
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.10),
                    Colors.white.withOpacity(0.045),
                  ],
                ),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(22),
            topRight: const Radius.circular(22),
            bottomLeft: Radius.circular(isUser ? 22 : 6),
            bottomRight: Radius.circular(isUser ? 6 : 22),
          ),
          border: Border.all(
            color: isUser ? Colors.white.withOpacity(0.12) : Colors.white.withOpacity(0.08),
          ),
          boxShadow: [
            BoxShadow(
              color: (isUser ? AppColors.accent : Colors.black).withOpacity(0.16),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : AppColors.text,
            fontSize: 14.5,
            height: 1.35,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
