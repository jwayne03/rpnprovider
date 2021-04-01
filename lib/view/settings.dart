import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpn/providers/settings_provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SettingsProvier settingsProvier;

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  int _valueHolder = 20;
  int get valueHolder => _valueHolder;

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
              activeColor: Colors.lightBlue,
              value: settingsProvier.isActionBarHidden,
              title: Text("Hide action bar"),
              onChanged: (bool value) {
                settingsProvier.isActionBarHidden = value;
              },
            ),
            SwitchListTile(
              activeColor: Colors.lightBlue,
              value: settingsProvier.isTrigonometricsHidden,
              title: Text("Hide Trigonometrics"),
              onChanged: (bool value) {
                settingsProvier.isTrigonometricsHidden = value;
              },
            ),
            SwitchListTile(
                activeColor: Colors.lightBlue,
                value: settingsProvier.isChangeTheFontSizeActive,
                title: Text("Change font of results screen"),
                onChanged: (bool value) {
                  settingsProvier.isChangeTheFontSizeActive = value;
                }),
            settingsProvier.isChangeTheFontSizeActive
                ? Column(
                    children: [
                      Slider(
                        value: _valueHolder.toDouble(),
                        min: 1,
                        max: 24,
                        divisions: 100,
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.grey,
                        label: '${_valueHolder.round()}',
                        onChanged: (double newValue) {
                          setState(() {
                            _valueHolder = newValue.round();
                          });
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
          ],
        ),
      ),
    );
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }
}
