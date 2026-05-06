class CommandCleaner {
  static String extractAppName(String command) {
    return command
        .replaceAll(RegExp(r'\b(abrir|abra|abre|app|aplicativo)\b', caseSensitive: false), '')
        .trim();
  }
}
