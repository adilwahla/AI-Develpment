import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';

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
}
