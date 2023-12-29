import 'dart:convert';

import 'package:my_app/config_dev.dart';
import 'package:my_app/models/socialmedia.dart';
import 'package:http/http.dart' as http;

typedef void SocialMediaTextCallback(String generatedContent);
typedef void SocialMediaTextFailureCallback(String message);

class SocialMediaService {
  Future<void> generateSocialMediaText({
    required String selectedPlatform,
    required String contentIdeas,
    required String captionsText,
    required String responseGeneration,
    required String? timeframe,
    required String? frequency,
    required String? type,
    required String? themes,
    required SocialMediaTextCallback onSuccess,
    required SocialMediaTextFailureCallback onFailure,
  }) async {
    final SocialMediaRequest request = SocialMediaRequest(
      selectedPlatform: selectedPlatform,
      contentIdeas: contentIdeas,
      captionsText: captionsText,
      responseGeneration: responseGeneration,
      timeframe: timeframe,
      frequency: frequency,
      type: type,
      themes: themes,
    );
    try {
      final response = await http.post(
        Uri.parse('${AppConfig.baseUrl}/api/socialMedia'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // Add any other headers if required
        },
        body: request.toJsonString(),
      );

      // Handle the response as per your requirements
      if (response.statusCode == 200) {
        // Process the response if needed

        print('Social media text generated successfully.$response');
        // Parse the JSON response to get the result

        Map<String, dynamic> jsonResponse = json.decode(response.body);
        String? generatedText = jsonResponse['result'] as String?;
        print("generated social media text =$generatedText");
        onSuccess(generatedText!);
      } else {
        // Handle errors appropriately
        print(
            'Failed to generate social media text. Status code: ${response.statusCode}');
        // Call the onFailure callback
        onFailure("failed to generate content");
      }
    } catch (e) {
      print('Error occurred: $e');
      onFailure("failed to generate content");
    }
  }
}
