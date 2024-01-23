import 'package:flutter/cupertino.dart';

class SelectedScreenProvider extends ChangeNotifier {
  String _screenName = "";

  // Getter for the screen name
  String getScreenName() {
    return _screenName;
  }

  // Setter for the screen name
  void setScreenName(String newScreenName) {
    if (_screenName != newScreenName) {
      _screenName = newScreenName;

      // Notify listeners that the screen name has changed
      notifyListeners();
    }
  }
}
