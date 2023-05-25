import 'package:flutter/material.dart';
import 'package:sitter_swipe/models/base_viewmodel.dart';

class BroadcastViewModel extends BaseViewModel with ChangeNotifier {
  bool? hasAlreadyBroadcasted = false;

  Future<bool> callForHelp(double radius) async {
    throw UnimplementedError();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }
}
