import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvier extends ChangeNotifier {
  bool _isActionBarHidden = false;
  bool _isTrigonometricsHidden = false;
  bool _isChangeTheFontSizeActive = false;
  double _fontSizeValue = 1;
  Color _colorTheme;

  SharedPreferences sharedPreferences;

  bool get isActionBarHidden => _isActionBarHidden;
  set isActionBarHidden(bool isHidden) {
    _isActionBarHidden = isHidden;
    notifyListeners();
  }

  bool get isTrigonometricsHidden => _isTrigonometricsHidden;
  set isTrigonometricsHidden(bool isHidden) {
    _isTrigonometricsHidden = isHidden;
    notifyListeners();
  }

  bool get isChangeTheFontSizeActive => _isChangeTheFontSizeActive;
  set isChangeTheFontSizeActive(bool isActive) {
    _isChangeTheFontSizeActive = isActive;
    notifyListeners();
  }

  double get fontSizeValue => _fontSizeValue;
  set fontSizeValue(double value) {
    _fontSizeValue = value;
    SharedPreferences.getInstance()
        .then((value) => value.setDouble("fontSize", fontSizeValue));
    notifyListeners();
  }

  Color get colorTheme => _colorTheme;
  set colorTheme(Color color) {
    _colorTheme = color;
    notifyListeners();
  }
}
