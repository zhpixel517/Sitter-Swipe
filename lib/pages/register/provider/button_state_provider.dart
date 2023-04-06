// On the registration screen, there are the forward and backward buttons
// This will help dictate whether they should be disabled or not

import 'package:flutter/material.dart';

class BlurProvider extends ChangeNotifier {
  bool shouldBlur = true;

  void blur() {
    shouldBlur = true;
    notifyListeners();
  }

  void unblur() {
    shouldBlur = false;
    notifyListeners();
  }
}
