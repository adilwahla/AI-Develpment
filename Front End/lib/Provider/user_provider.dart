import 'package:flutter/material.dart';
import 'package:my_app/models/UserPreference.dart';
import 'package:my_app/models/user.dart';

class UserProvider extends ChangeNotifier {

  User _user = User(
      token: '',
      id: '',
      name: '',
      email: '',
      password: '',
      countEmail: 0,
      countTranslate: 0,
      countReport: 0,
      countHours: 0);

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void updateUser(User newUser) async {
    _user = newUser;
    print('User updated: $_user'); // Debugging line

    // Save the updated user data to SharedPreferences
    UserPreferences userPreferences = UserPreferences();
    await userPreferences.saveUser(_user);

    notifyListeners(); // Notify listeners that the user object has changed
  }

  // Add a method to initialize user data from SharedPreferences if needed
  Future<void> initializeUser() async {
    UserPreferences userPreferences = UserPreferences();
    User savedUser = await userPreferences.getUser();
    _user = savedUser;
    notifyListeners();
  }
}
