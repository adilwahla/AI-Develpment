import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/config_dev.dart';
import 'package:my_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  // User _user =
  //     User(id: null, name: null, email: null, token: null, password: null);
  User? _user; // Declare as nullable
  User? get user => _user; // Make the getter nullable

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }

  void getUserData() async {
    try {
      // var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('${AppConfig.baseUrl}/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        // ignore: unused_local_variable
        http.Response userRes = await http.get(
          Uri.parse('${AppConfig.baseUrl}/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        //   userProvider.setUser(userRes.body);
      }
    } catch (e) {
      e.toString();
    }
  }
}
