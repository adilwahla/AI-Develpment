
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Auth_provider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void Login(String email, String password) async {
    setLoading(true);
    try {
      Response response = await http.post(
        Uri.parse('https://reqres.in/api/login'),
        body: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        print("Successful");
        setLoading(false);
      } else {
        print("error");
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      print(e.toString());
    }
  }
}
