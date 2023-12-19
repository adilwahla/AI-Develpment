import 'package:flutter/foundation.dart';
import 'package:my_app/services/emailService.dart';

class EmailProvider extends ChangeNotifier {
  EmailService emailService = EmailService();
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
