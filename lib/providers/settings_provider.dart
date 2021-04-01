import 'package:flutter/material.dart';

class SettingsProvier extends ChangeNotifier {
  bool _isActionBarHidden = false;
  bool _isTrigonometricsHidden = false;
  bool _isChangeTheFontSizeActive = false;
  double _fontSizeValue = 0;

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
    notifyListeners();
  }
}
