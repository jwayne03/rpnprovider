import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:rpn/providers/settings_provider.dart';

import 'package:rpn/view/rpn_calculator.dart';
import 'package:rpn/view/settings.dart';

class ResultsScreen extends StatefulWidget {
  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  SettingsProvier settingsProvier;
  Settings settings = Settings();
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    settingsProvier = Provider.of<SettingsProvier>(context);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });

    // Accedim a la calculadora i força el build cada vegada que
    // cridi notifyListeners()
    RPNCalculator calc = Provider.of<RPNCalculator>(context);

    return Container(
      margin: EdgeInsets.all(8.0),
      width: double.infinity,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade100,
        border: Border.all(
          color: Theme.of(context).accentColor,
          width: 2.0,
        ),
      ),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: calc.stack.length + 1,
        itemBuilder: (BuildContext context, int index) {
          String text = "";
          if (index < calc.stack.length) {
            text = calc.stack[index].toString();
          } else if (calc.isEditing) {
            text = calc.editing;
          }
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0.0,
              vertical: 6.0,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Text(
                    "${calc.stack.length - index}",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: settingsProvier.isChangeTheFontSizeActive
                            ? settingsProvier.fontSizeValue
                            : 16.0,
                        color: Theme.of(context).accentColor),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).accentColor,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 22.0),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
