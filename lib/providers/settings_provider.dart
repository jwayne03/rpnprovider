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
        await ConfigurationSettings().getUserSettings("actionBar") == "true";
    notifyListeners();
  }

  // save the state of the actionbar with sharedpreferences
  Future<void> saveActionBar() async {
    this._isActionBarHidden = (await ConfigurationSettings().updateUserSettings(
                "actionBar", this._isActionBarHidden.toString()))
            .toLowerCase() ==
        "false";
    this._loadActionBarState();
  }

  // GETTER AND SETTER OF TRIGONOMETRICS
  bool get isTrigonometricsHidden => _isTrigonometricsHidden;
  set isTrigonometricsHidden(bool isHidden) {
    this._isTrigonometricsHidden = isHidden;
    notifyListeners();
  }

  // load state of the trigonometrics if it's hidden or not with sharedpreferences
  Future<void> _loadTrigonometricsState() async {
    print(ConfigurationSettings().getUserSettings("trigonometrics"));
    this._isTrigonometricsHidden =
        await ConfigurationSettings().getUserSettings("trigonometrics") ==
            "true";
    notifyListeners();
  }

  // save the state of trigonometrics with sharedpreferences
  Future<void> saveTrigonometricsState() async {
    this._isTrigonometricsHidden = (await ConfigurationSettings()
                .updateUserSettings(
                    "trigonometrics", this._isTrigonometricsHidden.toString()))
            .toLowerCase() ==
        "false";
    this._loadTrigonometricsState();
  }

  // GETTER AND SETTER OF THE FONTSIZE SWITCH
  bool get isChangeTheFontSizeActive => _isChangeTheFontSizeActive;
  set isChangeTheFontSizeActive(bool isActive) {
    _isChangeTheFontSizeActive = isActive;
    notifyListeners();
  }

  // Load the value of the fontsize state with sharedpreferences
  Future<void> _loadFontSizeState() async {
    print(ConfigurationSettings().getUserSettings("fontSizeState"));
    this._isChangeTheFontSizeActive =
        await ConfigurationSettings().getUserSettings("fontSizeState") ==
            "true";
    notifyListeners();
  }

  // Safe the fontsize state switch with sharedpreferences
  Future<void> saveFontSizeState() async {
    this._isChangeTheFontSizeActive = (await ConfigurationSettings()
                .updateUserSettings("fontSizeState",
                    this._isChangeTheFontSizeActive.toString()))
            .toLowerCase() ==
        "false";
    this._loadFontSizeState();
  }

  // GETTER AND SETTER OF FONTSIZE VALUE
  double get fontSizeValue => _fontSizeValue;
  set fontSizeValue(double value) {
    _fontSizeValue = value;
    notifyListeners();
  }

  // Load the fontsize value with the sharedpreferences
  Future<void> _loadFontSizeValue() async {
    print(ConfigurationSettings().getUserSettings("fontSizeValue"));
    this._fontSizeValue = double.parse(
        ((await ConfigurationSettings().getUserSettings("fontSizeValue") ??
            16.0)));
  }

  // Save fontsize value with the sharedpreferences
  Future<void> saveFontSizeValue() async {
    print(ConfigurationSettings().getUserSettings("fontSizeValue"));
    this._fontSizeValue = double.parse(((await ConfigurationSettings()
            .updateUserSettings(
                "fontSizeValue", this._fontSizeValue.toString()) ??
        16.0)));
  }

  // GETTER AND SETTER OF COLOR THEME (COLOR PICKER)
  Color get colorTheme => _colorTheme;
  set colorTheme(Color color) {
    _colorTheme = color;
    notifyListeners();
  }

  // Load the color of the color picker with sharedpreferences
  Future<void> _loadCurrentColor() async {
    print(ConfigurationSettings().getUserSettings("themeColor"));
    this._colorTheme = Color(int.parse(
        (await ConfigurationSettings().getUserSettings("themeColor")) ??
            Colors.lightBlue.shade100.value));
  }

  // Save color theme with sharedpreferences
  Future<void> saveCurrentColorTheme() async {
    print(ConfigurationSettings().getUserSettings("themeColor"));
    this._colorTheme = ((await ConfigurationSettings().updateUserSettings(
            "themeColor", this._colorTheme.value.toString()) ??
        Colors.lightBlue.shade100.value.toString()) as Color);
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
