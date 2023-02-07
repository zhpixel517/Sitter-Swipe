import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/base_screen.dart';
import 'package:sitter_swipe/pages/login/login.dart';

class Wrapper extends StatelessWidget {
  Wrapper({super.key});
  dynamic user; // TODO: get from Provider
  // see the firebase_application project as an example

  @override
  Widget build(BuildContext context) {
    // return either Swipe page of Authenticate page
    if (user.uid == null) {
      return const LoginPage();
    } else {
      return BaseScreen();
    }
  }
}


// the widget will return either the main screen or the login screen
// depending on if the user is logged in or not 