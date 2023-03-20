import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/register/pages.dart';
import 'package:sitter_swipe/resources/fonts.dart';

class VerifyPhone extends StatefulWidget {
  const VerifyPhone({Key? key}) : super(key: key);

  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          RegisterPageTitles.verify,
          style: Fonts.bold,
        ),
      ),
      body: const Center(
        child: Text("verify"),
      ),
    );
  }
}
