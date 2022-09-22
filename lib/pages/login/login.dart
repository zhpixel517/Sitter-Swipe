import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/login/login_viewmodel.dart';
import 'package:sitter_swipe/pages/login/widgets/input_theme.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/routes.dart';
import 'package:sitter_swipe/resources/strings.dart';
import 'package:get_it/get_it.dart';

final instance = GetIt.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  @override
  void initState() {
    _bind();
    super.initState();
    emailNode.addListener(() {
      setState(() {});
    });
    passwordNode.addListener(() {
      setState(() {});
    });
  }

  _bind() {
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.globalContentSidePadding),
          child: Column(
            children: [
              Placeholder(),
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppPadding.p10),
                    child: TextField(
                      focusNode: emailNode,
                      keyboardType: TextInputType.text,
                      decoration:
                          getLoginInputDecoration(context, AppStrings.email)
                              .copyWith(
                        prefixIcon: Icon(
                          EvaIcons.email,
                          color: emailNode.hasFocus
                              ? Theme.of(context).primaryColor
                              : TanPallete.darkGrey,
                        ),
                        labelStyle: Fonts.bold.copyWith(
                            color: emailNode.hasFocus
                                ? Theme.of(context).primaryColor
                                : TanPallete.darkGrey,
                            fontSize: 17),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppPadding.p10),
                    child: TextField(
                      focusNode: passwordNode,
                      keyboardType: TextInputType.text,
                      decoration:
                          getLoginInputDecoration(context, AppStrings.password)
                              .copyWith(
                        prefixIcon: Icon(
                          EvaIcons.lock,
                          color: passwordNode.hasFocus
                              ? Theme.of(context).primaryColor
                              : TanPallete.darkGrey,
                        ),
                        labelStyle: Fonts.bold.copyWith(
                            color: passwordNode.hasFocus
                                ? Theme.of(context).primaryColor
                                : TanPallete.darkGrey,
                            fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
                child: ElevatedButton(
                  onPressed: () {},
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 30.0))),
                  child: Text(
                    AppStrings.login,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.forgotPassword);
                },
                child: Text(
                  AppStrings.forgotPassword,
                  style: Fonts.secondaryFont,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
