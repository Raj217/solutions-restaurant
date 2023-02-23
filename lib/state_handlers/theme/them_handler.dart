import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solutions/configs/configs.dart';
export 'themes/light_theme.dart';
export 'themes/dark_theme.dart';

class ThemeHandler extends ChangeNotifier {
  SharedPreferences? _prefs;
  late bool _isDarkTheme;

  bool get isDarkTheme => _isDarkTheme;

  ThemeHandler() {
    _isDarkTheme = false;
    _loadPrefs();
  }

  switchTheme() {
    _isDarkTheme = !_isDarkTheme;
    _savePrefs();
    notifyListeners();
  }

  _initiatePrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  _loadPrefs() async {
    await _initiatePrefs();
    _isDarkTheme = _prefs?.getBool(StorageValues.isDarkTheme.name) ?? false;
    notifyListeners();
  }

  _savePrefs() async {
    await _initiatePrefs();
    _prefs?.setBool(StorageValues.isDarkTheme.name, _isDarkTheme);
  }
}
