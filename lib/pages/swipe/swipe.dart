//swipe on families or babysitters
// part of baseScreen

import 'package:flutter/material.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({Key? key}) : super(key: key);

  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Swipe page"),
    );
  }
}
