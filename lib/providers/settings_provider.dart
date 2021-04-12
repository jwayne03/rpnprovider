import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvier extends ChangeNotifier {
  bool _isActionBarHidden = false;
  bool _isTrigonometricsHidden = false;
  bool _isChangeTheFontSizeActive = false;
  double _fontSizeValue = 1;
  Color _colorTheme;

  SharedPreferences _sharedPreferences;

  SettingsProvier() {
    this.loadActionBarState();
    this.loadFontSizeState();
    this.loadFontSizeValue();
    this.loadTrigonometricsState();
  }

  // ACTION BAR
  bool get isActionBarHidden => _isActionBarHidden;
  set isActionBarHidden(bool isHidden) {
    this._isActionBarHidden = isHidden;
    notifyListeners();
  }

  void loadActionBarState() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    this._isActionBarHidden =
        this._sharedPreferences.getBool("actionBar") ?? false;
    notifyListeners();
  }

  void saveActionBar() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool("actionBar", this._isActionBarHidden) as bool;
    notifyListeners();
  }

  // TRIGONOMETRICS
  bool get isTrigonometricsHidden => _isTrigonometricsHidden;
  set isTrigonometricsHidden(bool isHidden) {
    this._isTrigonometricsHidden = isHidden;
    notifyListeners();
  }

  void loadTrigonometricsState() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    this._isTrigonometricsHidden =
        this._sharedPreferences.getBool("trigonometrics") ?? false;
    notifyListeners();
  }

  void saveTrigonometricsState() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool("trigonometrics", this._isTrigonometricsHidden);
    notifyListeners();
  }

  // FONTSIZE SWITCH
  bool get isChangeTheFontSizeActive => _isChangeTheFontSizeActive;
  set isChangeTheFontSizeActive(bool isActive) {
    _isChangeTheFontSizeActive = isActive;
    notifyListeners();
  }

  void loadFontSizeState() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    this._isChangeTheFontSizeActive =
        this._sharedPreferences.getBool("activeFontSize") ?? false;
    notifyListeners();
  }

  Future<void> saveFontSizeState() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool(
        "activeFontSize", this._isChangeTheFontSizeActive) as bool;
    notifyListeners();
  }

  // FONTSIZE VALUE
  double get fontSizeValue => _fontSizeValue;
  set fontSizeValue(double value) {
    _fontSizeValue = value;
    SharedPreferences.getInstance()
        .then((value) => value.setDouble("fontSize", fontSizeValue));
    notifyListeners();
  }

  void saveFontSizeValue() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setDouble("fontSize", this._fontSizeValue) as double;
    notifyListeners();
  }

  void loadFontSizeValue() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    this._fontSizeValue = this._sharedPreferences.getDouble("fontSize") ?? 16.0;
    notifyListeners();
  }

  // COLOR THEME (COLOR PICKER)
  Color get colorTheme => _colorTheme;
  set colorTheme(Color color) {
    _colorTheme = color;
    notifyListeners();
  }

  void loadCurrentColor() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    this._colorTheme = Color(
        this._sharedPreferences.getInt("color") ?? Colors.lightBlue.value);
    notifyListeners();
  }

  void saveCurrentColorTheme() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    this._sharedPreferences.setInt("color", this._colorTheme.value);
    notifyListeners();
  }
}
