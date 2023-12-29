import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/models/UserPreference.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth_provider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  String? _token;
  String? _error;

  String? get token => _token;
  String? get error => _error;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    var result;
    try {
      print('before setloading $loading ');
      setLoading(true);
      print('after setloading $loading ');
      final http.Response res =
          await _authService.signInUser(email: email, password: password);

      if (res.statusCode == 200) {
        // Successful login
        final Map<String, dynamic> responseData = json.decode(res.body);
        _token = responseData['token'];
        _error = null;
        print('this is signInUser res $responseData');
        // Save token to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('x-auth-token', _token!);

        //TODO: set user data here and also user

        User authUser = User.fromJson(responseData);
        print('this is  User.fromJson(responseData) ${authUser.name} ');
        // now we will create shared preferences and save data
        UserPreferences().saveUser(authUser);
        // Return true indicating successful login

        notifyListeners();

        result = {'status': true, 'message': 'Successful', 'user': authUser};
        setLoading(false);
        return result;
      } else {
        // Login failed
        _token = null;
        _error = 'Authentication failed';
        result = {'status': false, 'message': _error};
        // Return false indicating unsuccessful login
        setLoading(false);
        return result;
      }
    } catch (e) {
      // Handle other errors
      _token = null;
      _error = 'An error occurred: $e';
      result = {'status': false, 'message': _error};
      // Return false indicating unsuccessful login
      setLoading(false);
      return result;
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
