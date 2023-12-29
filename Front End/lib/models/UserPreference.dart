import 'package:my_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  // Save user data to SharedPreferences
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('x-auth-token', user.token);
    prefs.setString(
        '_id', user.id); // Adjust based on your User model structure
    prefs.setString('name', user.name);
    prefs.setString('email', user.email);
    prefs.setString('password',
        user.password); // Consider if you need this, and store securely if necessary

    // ignore: deprecated_member_use
    return prefs.commit();
  }

  // Retrieve user data from SharedPreferences
  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('x-auth-token') ??
        ''; // Using the null-aware operator to provide a default empty string
    String? id = prefs.getString('_id') ?? ''; // Same here
    String? name = prefs.getString('name') ?? ''; // Same here
    String? email = prefs.getString('email') ?? ''; // Same here
    String? password = prefs.getString('password') ?? ''; // Same here
    return User(
      token: token,
      id: id,
      name: name,
      email: email,
      password: password,
    );
  }

  // Remove user data from SharedPreferences
  Future<void> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('x-auth-token');
    await prefs.remove('_id');
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('password'); // Consider if you need this

    // Clear all data (if you want to clear all preferences, not just user-specific)
    // await prefs.clear();
  }

  // Retrieve only the token from SharedPreferences
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('x-auth-token');
  }
}
