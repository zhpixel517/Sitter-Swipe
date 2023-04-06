import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sitter_swipe/pages/register/pages.dart';
import 'package:sitter_swipe/pages/register/register_viewmodel.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/strings.dart';
import 'package:sitter_swipe/services/di.dart';

class VerifyPhone extends StatefulWidget {
  const VerifyPhone({Key? key}) : super(key: key);

  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.sentVerification, style: Fonts.mediumStyle),
            Container(
              color: TanPallete.tan,
              child: const Pinput(
                  defaultPinTheme: PinTheme(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(
                              AppSizes.elevatedButtonBorderRadius)))),
                  length: 4,
                  androidSmsAutofillMethod: AndroidSmsAutofillMethod.none),
            ),
          ],
        ));
  }
}
