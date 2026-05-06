class MeganLogger {
  static void info(Object value) {
    // ignore: avoid_print
    print('[Megan][INFO] $value');
  }

  static void error(Object value) {
    // ignore: avoid_print
    print('[Megan][ERROR] $value');
  }
}
