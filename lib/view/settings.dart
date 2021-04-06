import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:rpn/providers/settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SettingsProvier settingsProvier;
  SharedPreferences sharedPreferences;

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  int _valueHolder = 12;
  int get valueHolder => _valueHolder;
  bool isChangeTheColor = false;

  Color get color => null;

  @override
  Widget build(BuildContext context) {
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
              },
            ),
            SwitchListTile(
              activeColor: Theme.of(context).primaryColor,
              value: settingsProvier.isTrigonometricsHidden,
              title: Text("Hide Trigonometrics"),
              onChanged: (bool value) {
                settingsProvier.isTrigonometricsHidden = value;
              },
            ),
            SwitchListTile(
              activeColor: Theme.of(context).primaryColor,
              value: settingsProvier.isChangeTheFontSizeActive,
              title: Text("Change font of results screen"),
              onChanged: (bool value) {
                settingsProvier.isChangeTheFontSizeActive = value;
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
            RaisedButton(
              elevation: 3.0,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      actions: <Widget>[
                        FlatButton(
                          child: const Text('Got it'),
                          onPressed: () {
                            setState(() {
                              currentColor = pickerColor;
                              settingsProvier.colorTheme = currentColor;
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
                          enableAlpha: true,
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

  void _saveFontSize(double fontSize) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSize', fontSize);
  }
}
