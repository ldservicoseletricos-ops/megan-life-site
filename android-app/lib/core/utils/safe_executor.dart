class SafeExecutor {
  static Future<T?> run<T>(Future<T> Function() task) async {
    try {
      return await task();
    } catch (_) {
      return null;
    }
  }
}
