import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/config_dev.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef void EmailGenerationCallback(String generatedEmailContent);
typedef void EmailGenerationFailureCallback();
//  final SharedPreferences prefs = await SharedPreferences.getInstance();

class EmailService {
  Future<void> generateEmail(
    String? object,
    String? selectType,
    String? emailTo,
    String? emailFrom,
    String? length,
    String? content,
    EmailGenerationCallback onSuccess,
    EmailGenerationFailureCallback onFailure,
  ) async {
    print("email fun called in EmailService ");
    try {
      // print('Before starting processing: ${EmailProcessProvider.isProcessing}');

      // print('After starting processing: ${EmailProcessProvider.isProcessing}');
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('x-auth-token') ?? '';
      print('this is token $token');
      final response = await http.post(
        Uri.parse('${AppConfig.baseUrl}/api/email'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
        body: jsonEncode({
          'object': object,
          'typeOfEmail': selectType,
          'emailTo': emailTo,
          'emailFrom': emailFrom,
          'length': length,
          'emailContent': content,
        }),
      );
      // print("this is response.body in EmailService=" + response.body);
      if (response.statusCode == 200) {
        // Decode the response body to a Map
        Map<String, dynamic> responseBody = json.decode(response.body);
        print("this is responseBody['generatedEmail' in EmailService=" +
            responseBody['generatedEmail']);
        // Access the content of the message
        String generatedEmailContent = responseBody['generatedEmail'];

        // Call the onSuccess callback with the generated email content
        onSuccess(generatedEmailContent);
      } else {
        // Call the onFailure callback
        onFailure();
      }
    } catch (error) {
      // Handle any exceptions that might occur during the HTTP request
      print('Error during email generation: $error');

      onFailure();
    }
  }
}
