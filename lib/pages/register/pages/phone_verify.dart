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
          title: Text(RegisterPageTitles.verify, style: Fonts.bold),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.globalContentSidePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: Text(
                  AppStrings.sentVerification,
                  style: Fonts.mediumStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
                child: Pinput(
                    pinAnimationType: PinAnimationType.fade,
                    preFilledWidget: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: TanPallete.tan),
                          borderRadius: BorderRadius.circular(
                              AppSizes.searchBarBorderRadius)),
                      width: AppSizes.pinputWidthAndHeight,
                      height: AppSizes.pinputWidthAndHeight,
                    ),
                    submittedPinTheme: PinTheme(
                        textStyle: Fonts.bold
                            .copyWith(fontSize: AppSizes.typingIndicatorSize),
                        width: AppSizes.pinputWidthAndHeight,
                        height: AppSizes.pinputWidthAndHeight,
                        decoration: BoxDecoration(
                            border: Border.all(color: TanPallete.tan),
                            borderRadius: BorderRadius.circular(
                                AppSizes.searchBarBorderRadius))),
                    focusedPinTheme: PinTheme(
                        textStyle: Fonts.bold
                            .copyWith(fontSize: AppSizes.typingIndicatorSize),
                        width: AppSizes.pinputWidthAndHeight,
                        height: AppSizes.pinputWidthAndHeight,
                        decoration: BoxDecoration(
                            border: Border.all(color: TanPallete.tan),
                            borderRadius: BorderRadius.circular(
                                AppSizes.searchBarBorderRadius))),
                    defaultPinTheme: const PinTheme(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(
                                AppSizes.elevatedButtonBorderRadius)))),
                    length: 6,
                    androidSmsAutofillMethod: AndroidSmsAutofillMethod.none),
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: Text(
                  "Data and messaging rates apply.",
                  style: Fonts.smallText,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ));
  }
}
