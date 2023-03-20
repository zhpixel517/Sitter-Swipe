// onboarding

//! do I even need this?
//TODO: where can I put this? can I put it after pressing the sign up button?
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/onboarding/widgets/onboarding_page.dart';
import 'package:sitter_swipe/resources/colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CarouselSlider(
          options:
              CarouselOptions(height: MediaQuery.of(context).size.height * 0.9),
          items: [
            CarouselPage(
              pageText: "Welcome to Sitter Swipe",
            )
          ],
        ),
      ),
    );
  }
}
