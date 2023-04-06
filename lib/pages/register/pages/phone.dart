import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitter_swipe/pages/register/pages.dart';
import 'package:sitter_swipe/pages/register/provider/button_state_provider.dart';
import 'package:sitter_swipe/pages/register/register_viewmodel.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/theme.dart';
import 'package:sitter_swipe/services/di.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final FocusNode phoneNumberFocusNode = FocusNode();
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  Key formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberTextController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    phoneNumberTextController.text = _viewModel.userPhoneNumber ?? "";
    // if they want to come back and edit their phone number, then
    // it needs to be saved inside the text box.
  }

  @override
  Widget build(BuildContext context) {
    final controlButtonBlurState =
        Provider.of<BlurProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
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
            body: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.globalContentSidePadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppPadding.p8),
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        controller: phoneNumberTextController,
                        onChanged: (value) {
                          _viewModel.setPhoneNumber(value);
                          if (value.length != AppSizes.phoneNumberLength) {
                            controlButtonBlurState.blur();
                          } else {
                            controlButtonBlurState.unblur();
                          }
                        },
                        validator: (value) =>
                            value!.length != AppSizes.phoneNumberLength
                                ? "Enter a valid phone number"
                                : null,
                        keyboardType: TextInputType.phone,
                        decoration: searchBarDecoration(phoneNumberFocusNode,
                            "Phone Number", EvaIcons.phoneCallOutline),
                      ),
                    ),
                  ),
                  Text(
                    "U.S and Canada phone numbers only",
                    style: Fonts.smallText,
                  ),
                ],
              ),
            )));
  }
}
