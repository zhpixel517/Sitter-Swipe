// account register
//! this should come AFTER the onboarding screen
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sitter_swipe/pages/register/pages.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<Widget> registerPages = const [
    PhoneNumber(),
    VerifyPhone(),
    Role(),
    Name(),
    Birthday(),
    About(),
    ProfileImages()
  ];
  CarouselController controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CarouselSlider(
            carouselController: controller,
            options: CarouselOptions(
                pageSnapping: true,
                height: MediaQuery.of(context).size.height,
                autoPlay: false,
                viewportFraction: 0.9),
            items: registerPages.map((i) {
              return Builder(
                builder: (context) {
                  return i;
                },
              );
            }).toList()),
      ),
    );
  }
}
