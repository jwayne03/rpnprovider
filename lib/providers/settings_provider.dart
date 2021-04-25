import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvier extends ChangeNotifier {
  bool _isActionBarHidden = false;
  bool _isTrigonometricsHidden = false;
  bool _isChangeTheFontSizeActive = false;
  double _fontSizeValue = 1;
  Color _colorTheme;
  String _userToken = "";

  SharedPreferences _sharedPreferences;

  // This constructor of calls to the methods of the sharedpreferences and their
  // methods are in private just in case
  SettingsProvier() {
    this._loadActionBarState();
    this._loadFontSizeState();
    this._loadFontSizeValue();
    this._loadTrigonometricsState();
    this._loadCurrentColor();
    this._loadUserToken();
  }

  // GETTER AND SETTER OF ACTION BAR
  bool get isActionBarHidden => _isActionBarHidden;
  set isActionBarHidden(bool isHidden) {
    this._isActionBarHidden = isHidden;
    notifyListeners();
  }

  // Load the state of the actionbar with sharedpreferences
  void _loadActionBarState() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    this._isActionBarHidden =
        this._sharedPreferences.getBool("actionBar") ?? false;
    notifyListeners();
  }

  // save the state of the actionbar with sharedpreferences
  void saveActionBar() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool("actionBar", this._isActionBarHidden) as bool;
    notifyListeners();
  }

  // GETTER AND SETTER OF TRIGONOMETRICS
  bool get isTrigonometricsHidden => _isTrigonometricsHidden;
  set isTrigonometricsHidden(bool isHidden) {
    this._isTrigonometricsHidden = isHidden;
    notifyListeners();
  }

  // load state of the trigonometrics if it's hidden or not with sharedpreferences
  void _loadTrigonometricsState() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    this._isTrigonometricsHidden =
        this._sharedPreferences.getBool("trigonometrics") ?? false;
    notifyListeners();
  }

  // save the state of trigonometrics with sharedpreferences
  void saveTrigonometricsState() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool("trigonometrics", this._isTrigonometricsHidden);
    notifyListeners();
  }

  // GETTER AND SETTER OF THE FONTSIZE SWITCH
  bool get isChangeTheFontSizeActive => _isChangeTheFontSizeActive;
  set isChangeTheFontSizeActive(bool isActive) {
    _isChangeTheFontSizeActive = isActive;
    notifyListeners();
  }

  // Load the value of the fontsize state with sharedpreferences
  void _loadFontSizeState() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    this._isChangeTheFontSizeActive =
        this._sharedPreferences.getBool("activeFontSize") ?? false;
    notifyListeners();
  }

  // Safe the fontsize state switch with sharedpreferences
  void saveFontSizeState() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool(
        "activeFontSize", this._isChangeTheFontSizeActive) as bool;
    notifyListeners();
  }

  // GETTER AND SETTER OF FONTSIZE VALUE
  double get fontSizeValue => _fontSizeValue;
  set fontSizeValue(double value) {
    _fontSizeValue = value;
    SharedPreferences.getInstance()
        .then((value) => value.setDouble("fontSize", fontSizeValue));
    notifyListeners();
  }

  // Save fontsize value with the sharedpreferences
  void saveFontSizeValue() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setDouble("fontSize", this._fontSizeValue) as double;
    notifyListeners();
  }

  // Load the fontsize value with the sharedpreferences
  void _loadFontSizeValue() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    this._fontSizeValue = this._sharedPreferences.getDouble("fontSize") ?? 16.0;
    notifyListeners();
  }

  // GETTER AND SETTER OF COLOR THEME (COLOR PICKER)
  Color get colorTheme => _colorTheme;
  set colorTheme(Color color) {
    _colorTheme = color;
    notifyListeners();
  }

  // Load the color of the color picker with sharedpreferences
  void _loadCurrentColor() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    this._colorTheme = Color(
        this._sharedPreferences.getInt("color") ?? Colors.lightBlue.value);
    notifyListeners();
  }

  // Save color theme with sharedpreferences
  void saveCurrentColorTheme() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    this._sharedPreferences.setInt("color", this._colorTheme.value);
    notifyListeners();
  }

  String get userToken => _userToken;
  set userToken(String token) {
    _userToken = token;
    notifyListeners();
  }

  void _loadUserToken() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    this._userToken = this._sharedPreferences.getString("token");
    notifyListeners();
  }

  void saveToken() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    this._sharedPreferences.setString("token", this._userToken);
    notifyListeners();
  }
}
