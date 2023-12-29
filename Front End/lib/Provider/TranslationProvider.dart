import 'package:flutter/material.dart';

import 'package:my_app/services/translationService.dart';

class TranslationProvider extends ChangeNotifier {
  TranslationService translationService = TranslationService();

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
}
