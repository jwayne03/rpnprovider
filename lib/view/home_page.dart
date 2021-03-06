import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpn/providers/settings_provider.dart';
import 'package:rpn/view/login.dart';
import 'package:rpn/widget/results_screen.dart';
import 'package:rpn/view/settings.dart';
import 'package:toast/toast.dart';

import '../widget/keypad.dart';
import 'key_definition.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SettingsProvier settingsProvier;
  int _currentPageIndex;

  //Color colorTheme = settingsProvier.colorTheme;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    print("HOME PAGEasdfasdfasdvSVZSFVZSFVZSFVZSFVZSFVZF");
    settingsProvier = Provider.of<SettingsProvier>(context);

    Color color = Theme.of(context).primaryColor;
    if (_currentPageIndex == 1 && settingsProvier.isTrigonometricsHidden) {
      setState(() => _currentPageIndex = 0);
    }
    print("HomePage build()");
    return Scaffold(
      appBar: settingsProvier.isActionBarHidden
          ? null
          : AppBar(
              title: Text("RPN Calculator"),
            ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ResultsScreen(),
            ),
            _currentPageIndex == 0
                ? Keypad(
                    numRows: 5,
                    numCols: 5,
                    keyDefinitions: KEYPAD_HOME,
                  )
                : Keypad(
                    numRows: 5,
                    numCols: 4,
                    keyDefinitions: KEYPAD_TRIGONOMETRICS,
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (int index) {
          if (index == 0) {
            setState(() => _currentPageIndex = index);
          } else if (index == 1) {
            if (!settingsProvier.isTrigonometricsHidden) {
              setState(() => _currentPageIndex = index);
            } else {
              Toast.show("Disabled", context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            }
          } else {
            if (settingsProvier.userToken == null) {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new Login()));
            } else {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new Settings()));
            }
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.square_foot,
              color: settingsProvier.isTrigonometricsHidden
                  ? Colors.grey.shade300
                  : Colors.grey.shade600,
            ),
            label: "Trigonometrics",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  List<KeyDefinition> KEYPAD_HOME = [
    KeyDefinition(
      text: "Clear",
      op: "clear",
      fontFactor: 0.5,
      color: Colors.grey.shade600,
    ),
    KeyDefinition(
        iconData: Icons.swap_vert,
        op: "swap",
        fontFactor: 1.0,
        color: Colors.grey.shade600),
    KeyDefinition(
        text: "%", op: "percent", fontFactor: 1.0, color: Colors.grey.shade600),
    KeyDefinition(
        text: "??", op: "pm", fontFactor: 1.0, color: Colors.grey.shade600),
    KeyDefinition(
        iconData: Icons.backspace,
        op: "back",
        fontFactor: 0.9,
        color: Colors.grey.shade600),
    KeyDefinition(
        text: "7", op: "7", fontFactor: 1.0, color: Colors.grey.shade600),
    KeyDefinition(
        text: "8", op: "8", fontFactor: 1.0, color: Colors.grey.shade600),
    KeyDefinition(
        text: "9", op: "9", fontFactor: 1.0, color: Colors.grey.shade600),
    KeyDefinition(
        text: "+", op: "+", fontFactor: 1.0, color: Colors.grey.shade600),
    KeyDefinition(
        text: "???", op: "sqrt", fontFactor: 1.0, color: Colors.grey.shade600),
    KeyDefinition(
        text: "4", op: "4", fontFactor: 1.0, color: Colors.grey.shade600),
    KeyDefinition(
        text: "5", op: "5", fontFactor: 1.0, color: Colors.grey.shade600),
    KeyDefinition(
        text: "6", op: "6", fontFactor: 1.0, color: Colors.grey.shade600),
    KeyDefinition(
        text: "-", op: "-", fontFactor: 1.0, color: Colors.grey.shade600),
    KeyDefinition(
        text: "x??", op: "square", fontFactor: 1.0, color: Colors.grey.shade600),
    KeyDefinition(
        text: "1", op: "1", fontFactor: 1.0, color: Colors.grey.shade600),
    KeyDefinition(
        text: "2", op: "2", fontFactor: 1.0, color: Colors.grey.shade600),
    KeyDefinition(
        text: "3", op: "3", fontFactor: 1.0, color: Colors.grey.shade600),
    KeyDefinition(
        iconData: Icons.close,
        op: "*",
        fontFactor: 1.0,
        color: Colors.grey.shade600),
    KeyDefinition(
        text: "x??", op: "pow", fontFactor: 0.65, color: Colors.grey.shade600),
    KeyDefinition(
        text: "0", op: "0", fontFactor: 1.0, color: Colors.grey.shade600),
    KeyDefinition(
        text: ".", op: ".", fontFactor: 1.0, color: Colors.grey.shade600),
    KeyDefinition(
        iconData: Icons.subdirectory_arrow_left,
        op: "enter",
        fontFactor: 1.0,
        color: Colors.grey.shade600),
    KeyDefinition(
        text: "/", op: "/", fontFactor: 1.0, color: Colors.grey.shade600),
    KeyDefinition(
        text: "1/x",
        op: "recip",
        fontFactor: 0.65,
        color: Colors.grey.shade600),
  ];

  List<KeyDefinition> KEYPAD_TRIGONOMETRICS = [
    KeyDefinition(
        text: "??", op: "pi", fontFactor: 0.6, color: Colors.grey.shade600),
    KeyDefinition(
        text: "????", op: "pi2", fontFactor: 0.6, color: Colors.grey.shade600),
    KeyDefinition(
        text: "2??", op: "2pi", fontFactor: 0.6, color: Colors.grey.shade600),
    KeyDefinition(
        text: "DEG\nto\nRAD",
        op: "d>r",
        fontFactor: 0.4,
        color: Colors.grey.shade600),
    KeyDefinition(
        text: "sin", op: "sin", fontFactor: 0.6, color: Colors.grey.shade600),
    KeyDefinition(
        text: "cos", op: "cos", fontFactor: 0.6, color: Colors.grey.shade600),
    KeyDefinition(
        text: "tan", op: "tan", fontFactor: 0.6, color: Colors.grey.shade600),
    KeyDefinition(
        text: "RAD\nto\nDEG",
        op: "r>d",
        fontFactor: 0.4,
        color: Colors.grey.shade600),
    KeyDefinition(
        text: "sin?????",
        op: "asin",
        fontFactor: 0.6,
        color: Colors.grey.shade600),
    KeyDefinition(
        text: "cos?????",
        op: "acos",
        fontFactor: 0.6,
        color: Colors.grey.shade600),
    KeyDefinition(
        text: "tan?????",
        op: "atan",
        fontFactor: 0.6,
        color: Colors.grey.shade600),
    KeyDefinition(
        text: "tan'?????",
        op: "atan2",
        fontFactor: 0.6,
        color: Colors.grey.shade600),
    KeyDefinition(
        text: "sinh", op: "sinh", fontFactor: 0.6, color: Colors.grey.shade600),
    KeyDefinition(
        text: "cosh", op: "cosh", fontFactor: 0.6, color: Colors.grey.shade600),
    KeyDefinition(
        text: "tanh", op: "tanh", fontFactor: 0.6, color: Colors.grey.shade600),
    KeyDefinition(
        text: "RECT\nto\nPOL",
        op: "r>p",
        fontFactor: 0.4,
        color: Colors.grey.shade600),
    KeyDefinition(
        text: "sinh?????",
        op: "asinh",
        fontFactor: 0.6,
        color: Colors.grey.shade600),
    KeyDefinition(
        text: "cosh?????",
        op: "acosh",
        fontFactor: 0.6,
        color: Colors.grey.shade600),
    KeyDefinition(
        text: "tanh?????",
        op: "atanh",
        fontFactor: 0.6,
        color: Colors.grey.shade600),
    KeyDefinition(
        text: "POL\nto\nRECT",
        op: "p>r",
        fontFactor: 0.4,
        color: Colors.grey.shade600),
  ];
}
