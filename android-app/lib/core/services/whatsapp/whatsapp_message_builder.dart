class WhatsAppMessageBuilder {
  String extractMessage(String command) {
    final lower = command.toLowerCase();
    final marker = 'dizendo';
    final index = lower.indexOf(marker);
    if (index >= 0) return command.substring(index + marker.length).trim();
    return command;
  }
}
