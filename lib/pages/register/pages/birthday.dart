// ask for user's birthday and calculate their age
import 'package:flutter/material.dart';

class Birthday extends StatefulWidget {
  const Birthday({super.key});

  @override
  State<Birthday> createState() => _BirthdayState();
}

class _BirthdayState extends State<Birthday> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Birthday"),
    );
  }
}
