import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/config_dev.dart';
import 'package:my_app/models/Report.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef ReportCallback = void Function(String result);

class ReportService {
  void GenerateReport({
    required String? documentText,
    required String? length,
    required String? language,
    required ReportCallback onSuccess,
    required ReportCallback onError,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('x-auth-token') ?? '';
      print('this is token $token');
      final response = await http.post(
        Uri.parse('${AppConfig.baseUrl}/api/report'),
        body: jsonEncode({
          'inputText': documentText,
          'length': length,
          'language': language,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );
      await Future.delayed(Duration(seconds: 2));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final reportResponse = ReportResponse.fromJson(data);
        onSuccess(reportResponse.generatedReport);
      } else {
        onError(
            'Failed to translate. Server responded with status ${response.statusCode}');
      }
    } catch (e) {
      onError('Error during translation: $e');
    }
  }
}
