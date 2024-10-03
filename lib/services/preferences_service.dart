import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _keyRecentEmojis = 'recent_emojis';

  // Guardar emojis recientes
  Future<void> saveRecentEmojis(List<String> emojis) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyRecentEmojis, emojis);
  }

  // Obtener emojis recientes
  Future<List<String>> getRecentEmojis() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyRecentEmojis) ?? [];
  }

  // Limpiar emojis recientes
  Future<void> clearRecentEmojis() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyRecentEmojis);
  }
}
