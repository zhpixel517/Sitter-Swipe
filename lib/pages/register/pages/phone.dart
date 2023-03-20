import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/register/pages.dart';
import 'package:sitter_swipe/resources/strings.dart';
import 'package:sitter_swipe/services/firebase/auth.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(EvaIcons.arrowBack),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                RegisterPageTitles.phoneNumber,
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .appBarTheme
                    .titleTextStyle!
                    .copyWith(fontSize: 23), // left align this
              ),
            ),
            body: const Center()));
  }
}
