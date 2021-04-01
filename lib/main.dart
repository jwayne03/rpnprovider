import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpn/providers/settings_provider.dart';
import 'package:rpn/view/rpn_calculator.dart';
import 'package:rpn/view/home_page.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => RPNCalculator()),
          ChangeNotifierProvider(create: (_) => SettingsProvier()),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  SettingsProvier settingsProvier;
  @override
  Widget build(BuildContext context) {
    settingsProvier = Provider.of<SettingsProvier>(context);
    return MaterialApp(
      title: 'RPN Calculator',
      theme: ThemeData(
        primarySwatch: settingsProvier.colorTheme,
        accentColor: settingsProvier.colorTheme,
      ),
      home: HomePage(),
    );
  }
}
