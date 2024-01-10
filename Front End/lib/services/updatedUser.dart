import 'dart:convert';

import 'package:my_app/config_dev.dart';
import 'package:my_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UpdatedUser {
  Future<User?> fetchUpdatedUserData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token') ?? '';

      final response = await http.get(
        Uri.parse('${AppConfig.baseUrl}/api/user'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);

        // Convert the fetched user data to your User model
        User updatedUser = User.fromJson(userData);
        print('updatedUser countReport${updatedUser.countReport}');
        return updatedUser; // Return the updated user
      } else {
        print(
            'Failed to fetch updated user data. Status code: ${response.statusCode}');
        return null; // Return null if failed to fetch user data
      }
    } catch (e) {
      print('Error fetching updated user data: $e');
      return null; // Return null if error occurs
    }
  }
}
