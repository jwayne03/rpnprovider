import 'package:flutter/material.dart';
import 'package:rpn/api/configuration_settings.dart';
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
    print("CONSTRUCTOR");
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
  Future<void> _loadActionBarState() async {
    print("LOADING USER SETTINGS IN PROVIDER");
    print(ConfigurationSettings().getUserSettings("actionBar"));
    this._isActionBarHidden =
        await ConfigurationSettings().getUserSettings("actionBar") == "false";
    notifyListeners();
  }

  // save the state of the actionbar with sharedpreferences
  Future<void> saveActionBar() async {
    this._isActionBarHidden = (await ConfigurationSettings().updateUserSettings(
                "actionBar", this._isActionBarHidden.toString()))
            .toLowerCase() ==
        "false";
  }

  // GETTER AND SETTER OF TRIGONOMETRICS
  bool get isTrigonometricsHidden => _isTrigonometricsHidden;
  set isTrigonometricsHidden(bool isHidden) {
    this._isTrigonometricsHidden = isHidden;
  }

  // load state of the trigonometrics if it's hidden or not with sharedpreferences
  Future<void> _loadTrigonometricsState() async {
    this._isTrigonometricsHidden =
        await ConfigurationSettings().getUserSettings("trigonometrics") ==
            "true";
    //_sharedPreferences.setBool(
    //   "trigonometrics", this._isChangeTheFontSizeActive) as bool;
  }

  // save the state of trigonometrics with sharedpreferences
  Future<void> saveTrigonometricsState() async {
    this._isTrigonometricsHidden = (await ConfigurationSettings()
                .updateUserSettings("trigonometrics",
                    this._isActionBarHidden ? "true" : "false"))
            .toLowerCase() ==
        "true";
  }

  // GETTER AND SETTER OF THE FONTSIZE SWITCH
  bool get isChangeTheFontSizeActive => _isChangeTheFontSizeActive;
  set isChangeTheFontSizeActive(bool isActive) {
    _isChangeTheFontSizeActive = isActive;
  }

  // Load the value of the fontsize state with sharedpreferences
  Future<void> _loadFontSizeState() async {}

  // Safe the fontsize state switch with sharedpreferences
  Future<void> saveFontSizeState() async {
    this._isChangeTheFontSizeActive = (await ConfigurationSettings()
                .updateUserSettings(
                    "actionBar", this._isActionBarHidden ? "true" : "false"))
            .toLowerCase() ==
        "true";
  }

  // GETTER AND SETTER OF FONTSIZE VALUE
  double get fontSizeValue => _fontSizeValue;
  set fontSizeValue(double value) {
    _fontSizeValue = value;
    SharedPreferences.getInstance()
        .then((value) => value.setDouble("fontSize", fontSizeValue));
  }

  // Save fontsize value with the sharedpreferences
  Future<void> saveFontSizeValue() async {
    this._fontSizeValue = (await ConfigurationSettings().saveUserSettings(
        "actionBar", this._fontSizeValue.toString(), userToken)) as double;
  }

  // Load the fontsize value with the sharedpreferences
  Future<void> _loadFontSizeValue() async {
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
  Future<void> _loadCurrentColor() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    this._colorTheme = Color(
        this._sharedPreferences.getInt("color") ?? Colors.lightBlue.value);
    notifyListeners();
  }

  // Save color theme with sharedpreferences
  Future<void> saveCurrentColorTheme() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    this._sharedPreferences.setInt("color", this._colorTheme.value);
    notifyListeners();
  }

  String get userToken => _userToken;
  set userToken(String token) {
    _userToken = token;
    notifyListeners();
  }

  Future<void> _loadUserToken() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    this._userToken = this._sharedPreferences.getString("token");
    notifyListeners();
  }

  Future<void> saveToken(String token) async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    this._sharedPreferences.setString("token", token);
    notifyListeners();
  }
}
