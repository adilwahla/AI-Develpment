import 'package:my_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

//password: '',countEmail:'',countTranslate:'',countReport:'',countHours:''
class UserPreferences {
  // Save user data to SharedPreferences
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('x-auth-token', user.token);
    prefs.setString(
        '_id', user.id); // Adjust based on your User model structure
    prefs.setString('name', user.name);
    prefs.setString('email', user.email);
    prefs.setString('password', user.password);
    prefs.setInt(
        'countEmail', user.countEmail); // Use setInt for integer values
    prefs.setInt(
        'countTranslate', user.countTranslate); // Use setInt for integer values
    prefs.setInt(
        'countReport', user.countReport); // Use setInt for integer values
    prefs.setInt(
        'countHours', user.countHours); // Use setInt for integer values
    prefs.setString('company', user.company);
    prefs.setString('bio', user.bio);
    prefs.setString('profilePicture', user.profilePicture);

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
    int? countEmail =
        prefs.getInt('countEmail') ?? 0; // Use getInt for integer values
    int? countTranslate =
        prefs.getInt('countTranslate') ?? 0; // Use getInt for integer values
    int? countReport =
        prefs.getInt('countReport') ?? 0; // Use getInt for integer values
    int? countHours =
        prefs.getInt('countHours') ?? 0; // Use getInt for integer values
    String? company = prefs.getString('company') ?? '';
    String? bio = prefs.getString('bio') ?? '';
    String? profilePicture = prefs.getString('profilePicture') ?? '';
    return User(
      token: token,
      id: id,
      name: name,
      email: email,
      password: password,
      countEmail: countEmail,
      countTranslate: countTranslate,
      countReport: countReport,
      countHours: countHours,
      company: company,
      bio: bio,
      profilePicture: profilePicture,
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
    await prefs.remove('countEmail'); // Consider if you need this
    await prefs.remove('countTranslate'); // Consider if you need this
    await prefs.remove('countReport'); // Consider if you need this
    await prefs.remove('countHours'); // Consider if you need this
    await prefs.remove('company'); // Consider if you need this
    await prefs.remove('bio'); // Consider if you need this
    await prefs.remove('profilePicture'); // Consider if you need this

    // Clear all data (if you want to clear all preferences, not just user-specific)
    // await prefs.clear();
  }

  // Retrieve only the token from SharedPreferences
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('x-auth-token');
  }
}
