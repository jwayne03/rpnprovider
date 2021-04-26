import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpn/api/configuration_settings.dart';
import 'package:rpn/providers/settings_provider.dart';
import 'package:rpn/view/settings.dart';
import 'package:toast/toast.dart';

import 'home_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  SettingsProvier settingsProvier;
  ConfigurationSettings configurationSettings;
  TextEditingController usernameController;
  TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    configurationSettings = ConfigurationSettings();
  }

  @override
  Widget build(BuildContext context) {
    settingsProvier = Provider.of<SettingsProvier>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 150,
                  child: Column(
                    children: [
                      Text(
                        "RPN Calculator",
                        style: TextStyle(fontSize: 28.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter valid user aluXXXXXXX'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            // ignore: missing_required_param
            FlatButton(
              onPressed: () {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: settingsProvier.colorTheme,
                  borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () async {
                  Toast.show("Checking the information...", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  String token = await configurationSettings.login(
                      usernameController.text, passwordController.text);
                  print(token);
                  if (token != null) {
                    settingsProvier.saveToken(token);
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => Settings()));
                  } else {
                    Toast.show(
                        "Username or Password incorrect, please try again.",
                        context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.BOTTOM);
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}
