import 'dart:convert';

import 'package:http/http.dart' as http;

class ConfigurationSettings {
  // REQUEST METHOD POST
  Future<String> login(String username, String password) async {
    var url = Uri.parse('https://api.flx.cat/users/user/token/refresh');

    http.Response response = await http
        .post(url, body: {"username": username, "password": password});

    Map<String, dynamic> json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return json['token'];
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  // REQUEST METHOD GET
  Future<String> getUserSettings(String name, String token) async {
    print("LOADING USER SETTINGS IN API REQUEST");
    print(token);

    var url = Uri.parse('https://api.flx.cat/users/setting/$name');

    http.Response response = await http.get(url, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode != 200) {
      print("Error ${response.statusCode}");
      return null;
    }

    Map<String, dynamic> json = jsonDecode(response.body);
    print(json['value']);
    print("HAS LLEGADO AQUI");
    return json['value'];
  }

  // REQUEST METHOD POST
  // ignore: missing_return
  Future<String> saveUserSettings(
      String name, String value, String token) async {
    var url = Uri.parse("https://api.flx.cat/users/setting");
    http.Response response = await http.post(url, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      "name": name,
      "value": value,
    });

    print(response.statusCode);
    if (response.statusCode != 200) {
      print(response.statusCode);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  Future<String> updateUserSettings(
      String name, String value, String token) async {
    print("UPDATE USER SETTINGS");
    var url = Uri.parse("https://api.flx.cat/users/setting/$name");
    http.Response response = await http.patch(url, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      "name": name,
      "value": value,
    });

    if (response.statusCode != 200) {
      print(response.statusCode);
      return this.saveUserSettings(name, value, token);
    } else {
      Map<String, dynamic> json = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      return json['value'];
    }
  }
}
