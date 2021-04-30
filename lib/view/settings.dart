import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:rpn/api/configuration_settings.dart';
import 'package:rpn/providers/settings_provider.dart';
import 'package:rpn/view/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SettingsProvier settingsProvier;
  SharedPreferences sharedPreferences;
  ConfigurationSettings configurationSettings;

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  int _valueHolder = 12;
  int get valueHolder => _valueHolder;
  bool isChangeTheColor = false;

  Color get color => null;

  @override
  Widget build(BuildContext context) {
    print("SETTINGS");
    settingsProvier = Provider.of<SettingsProvier>(context);
    return Scaffold(
      appBar: settingsProvier.isActionBarHidden
          ? null
          : AppBar(
              title: Text("Settings"),
            ),
      body: SafeArea(
        child: Column(
          children: [
            SwitchListTile(
              activeColor: Theme.of(context).primaryColor,
              value: settingsProvier.isActionBarHidden,
              title: Text("Hide action bar"),
              onChanged: (bool value) {
                settingsProvier.isActionBarHidden = value;
                settingsProvier.saveActionBar();
              },
            ),
            SwitchListTile(
              activeColor: Theme.of(context).primaryColor,
              value: settingsProvier.isTrigonometricsHidden,
              title: Text("Hide Trigonometrics"),
              onChanged: (bool value) {
                settingsProvier.isTrigonometricsHidden = value;
                settingsProvier.saveTrigonometricsState();
              },
            ),
            SwitchListTile(
              activeColor: Theme.of(context).primaryColor,
              value: settingsProvier.isChangeTheFontSizeActive,
              title: Text("Change font of results screen"),
              onChanged: (bool value) {
                settingsProvier.isChangeTheFontSizeActive = value;
                settingsProvier.saveFontSizeState();
              },
            ),
            settingsProvier.isChangeTheFontSizeActive
                ? Column(
                    children: [
                      Slider(
                        value: settingsProvier.fontSizeValue,
                        min: 1,
                        max: 30,
                        divisions: 100,
                        activeColor: Theme.of(context).primaryColor,
                        inactiveColor: Colors.grey,
                        label: '${settingsProvier.fontSizeValue}',
                        onChanged: (double newValue) {
                          settingsProvier.fontSizeValue = newValue;
                          settingsProvier.saveFontSizeValue();
                        },
                        semanticFormatterCallback: (double newValue) {
                          return '${newValue.round()}';
                        },
                      ),
                    ],
                  )
                : Visibility(
                    child: Text("Inactive"),
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: false,
                  ),
            // Raisedbutton is deprecate and I'll change it
            // This raisedbutton is a button to make the pop-up of the color picker
            RaisedButton(
              elevation: 3.0,
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      // Pop-up of color picker
                      actions: <Widget>[
                        FlatButton(
                          child: const Text('Save color'),
                          onPressed: () {
                            // Save the color that the user has picked up and
                            // save in sharedprefences
                            // and notifylistener to the provider
                            setState(() {
                              currentColor = pickerColor;
                              settingsProvier.colorTheme = currentColor;
                              settingsProvier.saveCurrentColorTheme();
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                      titlePadding: const EdgeInsets.all(0.0),
                      contentPadding: const EdgeInsets.all(0.0),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: currentColor,
                          onColorChanged: changeColor,
                          colorPickerWidth: 300.0,
                          pickerAreaHeightPercent: 0.7,
                          enableAlpha: false,
                          displayThumbColor: true,
                          showLabel: true,
                          paletteType: PaletteType.hsv,
                          pickerAreaBorderRadius: const BorderRadius.only(
                            topLeft: const Radius.circular(2.0),
                            topRight: const Radius.circular(2.0),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text("Change color"),
              color: Theme.of(context).primaryColor,
            ),
            RaisedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text("Do you want to unsubscribe?"),
                      actions: <Widget>[
                        FlatButton(
                          child: const Text('Yes'),
                          onPressed: () {
                            settingsProvier.userToken = null;
                            settingsProvier.saveToken(null);
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          },
                        ),
                        FlatButton(
                          child: const Text('No'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("Unsubscribe"),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }

  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
    });
    print(currentColor);
  }
}
