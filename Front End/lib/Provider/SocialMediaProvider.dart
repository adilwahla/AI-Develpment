import 'package:flutter/foundation.dart';
import 'package:my_app/services/socialMediaServices.dart';

class SocialMediaProvider with ChangeNotifier {
  final SocialMediaService service = SocialMediaService();
  bool _isProcessing = false;

  bool get isProcessing => _isProcessing;

  void startProcessing() {
    _isProcessing = true;
    notifyListeners();
  }

  void stopProcessing() {
    _isProcessing = false;
    notifyListeners();
  }

  Future<void> generateSocialMediaText({
    required String selectedPlatform,
    required String contentIdeas,
    required String captionsText,
    required String responseGeneration,
    required String? timeframe,
    required String? frequency,
    required String? type,
    required String? themes,
    required Function(String) onSuccess, // Callback for success
    required Function(String) onFailure, // Callback for failure
  }) async {
    try {
 

      await service.generateSocialMediaText(
        selectedPlatform: selectedPlatform,
        contentIdeas: contentIdeas,
        captionsText: captionsText,
        responseGeneration: responseGeneration,
        timeframe: timeframe,
        frequency: frequency,
        type: type,
        themes: themes,
        onSuccess: onSuccess,
        onFailure: onFailure,
      );

   
    } catch (e) {
      print('error $e');
    
      notifyListeners();
    }
  }
}
