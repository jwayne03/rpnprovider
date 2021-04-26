import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rpn/providers/settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationSettings {
  SharedPreferences sharedPreferences;
  SettingsProvier settingsProvier;
  static const TOKEN =
      "d6b9f84c9602cf963ee792314ac86c2189e03ed7e68a25b30261d235c4d025b4325224b3c219a67740f6faf191925d70b3d9b6e080039b0f51efa9918269abd6";

  Future<String> login(String username, String password) async {
    var url = Uri.parse('https://api.flx.cat/users/user/token/refresh');

    http.Response response = await http
        .post(url, body: {"username": username, "password": password});

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.reasonPhrase);
    }
  }
}
