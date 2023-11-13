import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/Provider/user_provider.dart';
import 'package:my_app/Screens/Home.dart';
import 'package:my_app/Utils.dart';
import 'package:my_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
static  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user =
          User(id: '', name: name, email: email, token: '', password: password);

      http.Response res = await http.post(
        Uri.parse('http://localhost:3000/api/users/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
