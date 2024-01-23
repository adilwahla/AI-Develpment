import 'dart:async';
import 'dart:convert';

import 'package:my_app/Provider/user_provider.dart';
import 'package:my_app/config_dev.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UpdateProfile {
  Future<bool> updateProfile({
    required String? fullName,
    required String? newEmail,
    required String? companyName,
    required String? tagLine,
    required String? profilePicture,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token') ?? '';

    try {
      final Map<String, dynamic> body = {
        'fullName': fullName,
        'newEmail': newEmail,
        'companyName': companyName,
        'tagLine': tagLine,
        'profilePicture': profilePicture,
      };

      final response = await http.put(
        Uri.parse('${AppConfig.baseUrl}/api/updateProfile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
        body: jsonEncode(body), // Encode the body as JSON
      );

      if (response.statusCode == 200) {
        //update user here

        print('Profile updated successfully ${response.body}');
        
        return true;
      } else {
        print('Failed to update profile. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error updating profile: $e');
      // You might want to handle the error differently based on your requirement.
      return false;
    }
  }

  Future<bool> updatePassword({
    required String? newPassword,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token') ?? '';

    try {
      final Map<String, dynamic> body = {
        'newPassword': newPassword,
      };

      final response = await http.put(
        Uri.parse('${AppConfig.baseUrl}/api/updatePassword'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
        body: jsonEncode(body), // Encode the body as JSON
      );

      if (response.statusCode == 200) {
        print('Password updated successfully');
        return true;
      } else {
        print('Failed to update password. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error updating password: $e');
      // Handle the error as per your requirements.
      return false;
    }
  }
}
