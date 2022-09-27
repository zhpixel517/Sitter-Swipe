import 'package:flutter/material.dart';
import 'package:sitter_swipe/resources/strings.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              AppStrings.phoneNumber,
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .appBarTheme
                  .titleTextStyle!
                  .copyWith(fontSize: 30), // left align this
            ),
          )
        ],
      ),
    );
  }
}
