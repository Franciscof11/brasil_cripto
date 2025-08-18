import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeBoxName = 'theme_box';
  static const String _isDarkModeKey = 'is_dark_mode';

  late Box _themeBox;
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  Future<void> init() async {
    try {
      _themeBox = await Hive.openBox(_themeBoxName);
      _isDarkMode = _themeBox.get(_isDarkModeKey, defaultValue: false);
      notifyListeners();
    } catch (e) {
      debugPrint('Erro ao inicializar ThemeProvider: $e');
      _isDarkMode = false;
    }
  }

  Future<void> toggleTheme() async {
    try {
      _isDarkMode = !_isDarkMode;
      await _themeBox.put(_isDarkModeKey, _isDarkMode);
      notifyListeners();
    } catch (e) {
      debugPrint('Erro ao alternar tema: $e');
    }
  }

  Future<void> setDarkMode(bool isDark) async {
    try {
      if (_isDarkMode != isDark) {
        _isDarkMode = isDark;
        await _themeBox.put(_isDarkModeKey, _isDarkMode);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Erro ao definir modo escuro: $e');
    }
  }

  @override
  void dispose() {
    _themeBox.close();
    super.dispose();
  }
}
