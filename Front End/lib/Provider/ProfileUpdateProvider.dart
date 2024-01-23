import 'package:flutter/foundation.dart';
import 'package:my_app/services/updateProfile.dart';

class ProfileUpdateProvider extends ChangeNotifier {
  UpdateProfile updateProfile = UpdateProfile();
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
