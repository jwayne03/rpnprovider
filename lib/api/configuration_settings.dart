import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:rpn/providers/settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationSettings {
  SharedPreferences sharedPreferences;
  SettingsProvier settingsProvier = SettingsProvier();

  // REQUEST METHOD POST
  Future<String> login(String username, String password) async {
    var url = Uri.parse('https://api.flx.cat/users/user/token/refresh');

    http.Response response = await http
        .post(url, body: {"username": username, "password": password});

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  // REQUEST METHOD GET
  Future<List<dynamic>> getUserSettings() async {
    var url = Uri.parse('https://api.flx.cat/users/setting');
    String token =
        'a12e738dbc5949d4658ff8501b5b1f7adfdea976000f64ca3ccba1a4dada9f6094a716e47bde55628076c05a031dc15b6bb325b4e770931b018e98646f32c01a';
    http.Response response = await http.get(url, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode != 200) {
      print("Error ${response.statusCode}");
      return null;
    }
    List<dynamic> json = jsonDecode(response.body);
    print(json);
    return json;
  }

  // REQUEST METHOD POST
  Future<String> saveUserSettings(
      String name, String value, String token) async {
    String a =
        'a12e738dbc5949d4658ff8501b5b1f7adfdea976000f64ca3ccba1a4dada9f6094a716e47bde55628076c05a031dc15b6bb325b4e770931b018e98646f32c01a';
    var url = Uri.parse("https://api.flx.cat/users/setting");
    http.Response response = await http.post(url,
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $a',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          "name": name,
          "value": value,
        }));

    print(response.statusCode);
    if (response.statusCode != 200) {
      print(response.statusCode);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  Future<void> updateUserSettings(String name, String value) async {
    String a =
        'a12e738dbc5949d4658ff8501b5b1f7adfdea976000f64ca3ccba1a4dada9f6094a716e47bde55628076c05a031dc15b6bb325b4e770931b018e98646f32c01a';
    var url = Uri.parse("https://api.flx.cat/users/setting/$name");
    http.Response response = await http.patch(url, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer $a',
      'Content-Type': 'application/json',
    }, body: {
      "value": value,
    });

    if (response.statusCode != 200) {
      print(response.statusCode);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }
}
