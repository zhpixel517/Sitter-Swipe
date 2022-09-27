// screen for getting a new password
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/strings.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final FocusNode emailNode = FocusNode();

  @override
  void initState() {
    super.initState();
    emailNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(EvaIcons.arrowBack),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(AppStrings.forgotPassword),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.globalContentSidePadding),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.elevatedButtonVerticalPadding),
              child: TextField(
                focusNode: emailNode,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      EvaIcons.email,
                      color: emailNode.hasFocus
                          ? TanPallete.tan
                          : TanPallete.darkGrey,
                    ),
                    labelStyle: Fonts.bold.copyWith(
                        color: emailNode.hasFocus
                            ? TanPallete.tan
                            : TanPallete.darkGrey,
                        fontSize: AppSizes.textFieldLabelSize),
                    labelText: AppStrings.email),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.elevatedButtonVerticalPadding),
              child: ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 30.0)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal:
                                  AppPadding.elevatedButtonHorizontalPadding,
                              vertical:
                                  AppPadding.elevatedButtonVerticalPadding))),
                  onPressed: () {
                    // send an email
                  },
                  child: Text(
                    AppStrings.resetPassword,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
