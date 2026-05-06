class BrainResult {
  const BrainResult({
    required this.ok,
    required this.intentType,
    required this.action,
    required this.response,
    this.requiresAndroid = false,
    this.raw = const {},
  });

  final bool ok;
  final String intentType;
  final String action;
  final String response;
  final bool requiresAndroid;
  final Map<String, dynamic> raw;

  factory BrainResult.fromJson(Map<String, dynamic> json) {
    final intent = (json['intent'] as Map?)?.cast<String, dynamic>() ?? {};
    final plan = (json['plan'] as Map?)?.cast<String, dynamic>() ?? {};
    return BrainResult(
      ok: json['ok'] == true,
      intentType: '${intent['type'] ?? 'unknown'}',
      action: '${plan['action'] ?? 'unknown'}',
      response: '${json['response'] ?? ''}',
      requiresAndroid: plan['requiresAndroid'] == true,
      raw: json,
    );
  }

  factory BrainResult.local({
    required String intentType,
    required String action,
    required String response,
    bool requiresAndroid = true,
  }) {
    return BrainResult(
      ok: true,
      intentType: intentType,
      action: action,
      response: response,
      requiresAndroid: requiresAndroid,
    );
  }
}
