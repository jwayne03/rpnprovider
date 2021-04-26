import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rpn/providers/settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationSettings {
  SharedPreferences sharedPreferences;
  SettingsProvier settingsProvier;

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
  Future<Map<String, String>> getUserSettings(String url) async {
    var url = Uri.parse('https://api.flx.cat/users/setting');
    http.Response response = await http.get(url);
    if (response.statusCode != 200) {
      print("Error ${response.statusCode}");
      return null;
    }
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json['code'] != 200) {
      print("Error from response ${json['code']}");
      return null;
    }
    return json;
  }

  // REQUEST METHOD POST
  Future<Map<String, String>> saveUserSettings(String url) async {
    var url = Uri.parse('https://api.flx.cat/users/setting');
  }
}
