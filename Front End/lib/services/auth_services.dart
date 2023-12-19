import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/config_dev.dart';
import 'package:my_app/models/translate.dart';

typedef TranslationCallback = void Function(String result);

class AuthService {
  Future<http.Response> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('${AppConfig.baseUrl}/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  void translate({
    required String? documentText,
    required String? input,
    required String language,
    required TranslationCallback onTranslation,
    required TranslationCallback onError,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConfig.baseUrl}/api/translate'),
        body: jsonEncode({
          'documentText': documentText,
          'inputText': input,
          'targetLanguage': language,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final translationResponse = TranslationResponse.fromJson(data);
        onTranslation(translationResponse.translatedText);
      } else {
        onError(
            'Failed to translate. Server responded with status ${response.statusCode}');
      }
    } catch (e) {
      onError('Error during translation: $e');
    }
  }
}
