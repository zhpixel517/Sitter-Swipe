// bio and other information
import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/register/pages.dart';
import 'package:sitter_swipe/resources/fonts.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          RegisterPageTitles.about,
          style: Fonts.bold,
        ),
      ),
      body: const Center(
        child: Text("About"),
      ),
    );
  }
}
