import 'dart:async';

import 'package:sitter_swipe/models/base_viewmodel.dart';
import 'package:sitter_swipe/services/functions/email_check.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  String _email = '';
  String _password = '';

  @override
  void dispose() {
    _emailStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  @override
  void start() {}

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  login() {
    //! Some firebase junk goes here
    //! do I need something like a LoginUseCase? State Renderer?
  }

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordNotEmpty(password));

  @override
  setEmail(String email) {
    print("set email was called");
    inputEmail.add(email);
    _email = email;
    _validate();
  }

  @override
  setPassword(String password) {
    print("set password was called");
    inputPassword.add(password);
    _password = password;
    _validate();
  }

  _validate() {
    inputIsAllInputsValid.add(null);
  }

  bool _isPasswordNotEmpty(String password) {
    return password.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return isEmailValid(_email) && _isPasswordNotEmpty(_password);
  }
}

abstract class LoginViewModelInputs {
  setEmail(String email);
  setPassword(String password);
  login();

  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputIsAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputsValid;
}
