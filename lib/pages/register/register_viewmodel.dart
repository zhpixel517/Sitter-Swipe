import 'dart:async';
import 'package:sitter_swipe/models/base_viewmodel.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelOutputs, RegisterViewModelInputs {
  final StreamController<bool> _hasEnteredPhoneNumber =
      StreamController.broadcast();

  @override
  // TODO: implement hasEnteredPhoneNumber
  Sink<bool> get hasEnteredPhoneNumber => _hasEnteredPhoneNumber.sink;

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }
}

abstract class RegisterViewModelOutputs {
  Sink<bool> get hasEnteredPhoneNumber;
}

abstract class RegisterViewModelInputs {}
