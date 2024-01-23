import 'package:flutter/foundation.dart';
import 'package:my_app/services/updateProfile.dart';

class ProcessProvider extends ChangeNotifier {
  UpdateProfile updateProfile = UpdateProfile();
  bool _isUpdating = false;

  bool get isUpdating => _isUpdating;

  void startProcessing() {
    _isUpdating = true;
    notifyListeners();
  }

  void stopProcessing() {
    _isUpdating = false;
    notifyListeners();
  }
}
