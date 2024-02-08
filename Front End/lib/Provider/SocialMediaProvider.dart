import 'package:flutter/foundation.dart';
import 'package:my_app/services/socialMediaServices.dart';

class SocialMediaProvider with ChangeNotifier {
  final SocialMediaService service = SocialMediaService();
  bool _isProcessing = false;
  String _platform = '';
  bool get isProcessing => _isProcessing;
  String get platform => _platform;
  void startProcessing() {
    _isProcessing = true;
    notifyListeners();
  }

  void stopProcessing() {
    _isProcessing = false;
    notifyListeners();
  }

  void setPlatform(String newPlatform) {
    _platform = newPlatform;
    notifyListeners();
  }
 List<bool> _buttonSelections = [false, false, false, false];

  List<bool> get buttonSelections => _buttonSelections;

  void selectButton(int index) {
    if (index >= 0 && index < _buttonSelections.length) {
      // Set the selected button to true
      _buttonSelections[index] = true;

      // Set all other buttons to false
      for (int i = 0; i < _buttonSelections.length; i++) {
        if (i != index) {
          _buttonSelections[i] = false;
        }
      }

      // Notify listeners about the change
      notifyListeners();
    }
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
