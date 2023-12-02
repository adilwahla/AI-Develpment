import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth_provider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  String? _token;
  String? _error;

  String? get token => _token;
  String? get error => _error;

  Future<bool> loginUser(String email, String password) async {
    try {
      final http.Response res =
          await _authService.signInUser(email: email, password: password);

      if (res.statusCode == 200) {
        // Successful login
        final Map<String, dynamic> responseData = json.decode(res.body);
        _token = responseData['token'];
        _error = null;

        // Save token to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('x-auth-token', _token!);

        // Return true indicating successful login
        return true;
      } else {
        // Login failed
        _token = null;
        _error = 'Authentication failed';

        // Return false indicating unsuccessful login
        return false;
      }
    } catch (e) {
      // Handle other errors
      _token = null;
      _error = 'An error occurred: $e';

      // Return false indicating unsuccessful login
      return false;
    } finally {
      // Notify listeners to update the UI
      notifyListeners();
    }
  }
}




  // bool _loading = false;
  // bool get loading => _loading;
  // setLoading(bool value) {
  //   _loading = value;
  //   notifyListeners();
  // }

  // void Login(String email, String password) async {
  //   setLoading(true);
  //   try {
  //     Response response = await http.post(
  //       Uri.parse('https://reqres.in/api/login'),
  //       body: {"email": email, "password": password},
  //     );

  //     if (response.statusCode == 200) {
  //       print("Successful");
  //       setLoading(false);
  //     } else {
  //       print("error");
  //       setLoading(false);
  //     }
  //   } catch (e) {
  //     setLoading(false);
  //     print(e.toString());
  //   }
  // }

