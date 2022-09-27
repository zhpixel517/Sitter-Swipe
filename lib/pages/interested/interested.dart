// families or other babysitters interested
// part of baseScreen
import 'package:flutter/material.dart';
import 'package:sitter_swipe/resources/strings.dart';

class InterestedPage extends StatefulWidget {
  const InterestedPage({Key? key}) : super(key: key);

  @override
  _InterestedPageState createState() => _InterestedPageState();
}

class _InterestedPageState extends State<InterestedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(PageTitles.interested),
      ),
    );
  }
}
