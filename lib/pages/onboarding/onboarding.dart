// onboarding

//! do I even need this?
import 'package:flutter/material.dart';
import 'package:sitter_swipe/resources/colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: TanPallete.tan,
    );
  }
}
