import 'package:shared_preferences/shared_preferences.dart';

class LocalMemoryStore {
  static const _key = 'megan_local_memories';

  Future<void> save(String text) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getStringList(_key) ?? [];
    current.add(text);
    await prefs.setStringList(_key, current);
  }

  Future<List<String>> all() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }
}
