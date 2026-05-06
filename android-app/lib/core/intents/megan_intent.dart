enum MeganIntentType {
  openApp,
  sendWhatsApp,
  readNotifications,
  navigation,
  localTime,
  aiChat,
  unknown,
}

class MeganIntent {
  const MeganIntent({required this.type, required this.confidence});

  final MeganIntentType type;
  final double confidence;
}
