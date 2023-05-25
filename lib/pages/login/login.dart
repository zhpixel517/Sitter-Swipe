import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sitter_swipe/pages/login/login_viewmodel.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/routes.dart';
import 'package:sitter_swipe/resources/strings.dart';
import 'package:sitter_swipe/resources/theme.dart';
import 'package:sitter_swipe/services/di.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> requestNeededPermissions() async {
    await [Permission.location].request();
  }

  @override
  void initState() {
    _bind();
    super.initState();
    emailNode.addListener(() {
      setState(() {});
      print("updated this junk here");
    });
    passwordNode.addListener(() {
      setState(() {});
    });
  }

  _bind() async {
    _viewModel.start();
    await requestNeededPermissions();
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.globalContentSidePadding),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.15),
                    child: const Center(
                        child: ClipRRect(
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppSizes.elevatedButtonBorderRadius)),
                      child: Image(
                        image: AssetImage(
                            "assets/images/IconKitchen-Output/ios/AppIcon~ios-marketing.png"),
                      ),
                    )),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppPadding.p10),
                          child: StreamBuilder<bool>(
                              stream: _viewModel.outputIsEmailValid,
                              builder: (context, snapshot) {
                                return TextFormField(
                                    validator: (text) => text!.isEmpty
                                        ? AppStrings.invalidEmail
                                        : null,
                                    focusNode: emailNode,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: globalInputDecoration(emailNode,
                                        AppStrings.email, EvaIcons.emailOutline)

                                    /* InputDecoration(
                                      errorText: snapshot.data ?? true
                                          ? null
                                          : AppStrings.invalidEmail,
                                      prefixIcon: Icon(
                                        EvaIcons.email,
                                        color: emailNode.hasFocus
                                            ? Theme.of(context).primaryColor
                                            : TanPallete.lightGrey,
                                      ),
                                      labelStyle: Fonts.bold.copyWith(
                                          color: emailNode.hasFocus
                                              ? Theme.of(context).primaryColor
                                              : TanPallete.lightGrey,
                                          fontSize:
                                              AppSizes.textFieldLabelSize),
                                      labelText: AppStrings.email), */
                                    );
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppPadding.p10),
                          child: StreamBuilder<bool>(
                              stream: _viewModel.outputIsPasswordValid,
                              builder: (context, snapshot) {
                                return TextFormField(
                                    validator: (text) => text!.isEmpty
                                        ? "Enter your password"
                                        : null,
                                    obscureText: true,
                                    focusNode: passwordNode,
                                    keyboardType: TextInputType.text,
                                    decoration: globalInputDecoration(
                                        passwordNode,
                                        "Password",
                                        EvaIcons.lockOutline));
                              }),
                        ),
                        /*
                            InputDecoration(
                                    labelText: AppStrings.password,
                                    errorText: (snapshot.data ?? true)
                                        ? null
                                        : AppStrings.password,
                                    prefixIcon: Icon(
                                      EvaIcons.lock,
                                      color: passwordNode.hasFocus
                                          ? Theme.of(context).primaryColor
                                          : TanPallete.lightGrey,
                                    ),
                                    labelStyle: Fonts.bold.copyWith(
                                        color: passwordNode.hasFocus
                                            ? Theme.of(context).primaryColor
                                            : TanPallete.lightGrey,
                                        fontSize: AppSizes.textFieldLabelSize),
                                  ),
                        */
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppPadding.p10),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          //TODO: push login actions
                          Navigator.pushNamed(context, Routes.baseScreen);
                          _viewModel.login();
                        }
                      },
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style!
                          .copyWith(
                              minimumSize: MaterialStateProperty.all(
                                  const Size(double.infinity, 30.0)),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: AppPadding
                                          .elevatedButtonHorizontalPadding,
                                      vertical: AppPadding
                                          .elevatedButtonVerticalPadding))),
                      child: Text(
                        AppStrings.login,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  SignInButton(
                    Buttons.GoogleDark,
                    text: "Sign in with Google",
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(
                            AppSizes.elevatedButtonBorderRadius))),
                    elevation: 0.0,
                    onPressed: () {},
                  ),
                  SignInButton(
                    Buttons.AppleDark,
                    elevation: 0.0,
                    text: "Sign in with Apple",
                    onPressed: () {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.register);
                          },
                          child: Text(
                            AppStrings.register,
                            style: Fonts.secondaryFont,
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.forgotPassword);
                        },
                        child: Text(
                          AppStrings.forgotPassword,
                          style: Fonts.secondaryFont,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
