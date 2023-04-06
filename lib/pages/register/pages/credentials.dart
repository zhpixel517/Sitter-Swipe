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

class Credentials extends StatefulWidget {
  const Credentials({super.key});

  @override
  State<Credentials> createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  Key formKey = GlobalKey<FormState>();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode nickNameFocusNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controlButtonBlurState =
        Provider.of<BlurProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              RegisterPageTitles.credentials,
              style: Fonts.bold,
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.globalContentSidePadding),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
                  child: TextFormField(
                    controller: nameController,
                    focusNode: nameFocusNode,
                    onChanged: (value) {
                      _viewModel.setFullname(nameController.text);
                    },
                    decoration: searchBarDecoration(
                        emailFocusNode, "Full name", EvaIcons.personOutline),
                  ),
                ),
                Text("Your full name will be displayed on your profile.",
                    style: Fonts.smallText),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
                  child: TextFormField(
                    controller: emailController,
                    focusNode: emailFocusNode,
                    onChanged: (value) {
                      _viewModel.setEmail(emailController.text);
                    },
                    decoration: searchBarDecoration(emailFocusNode,
                        "Enter an email", EvaIcons.emailOutline),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    onChanged: (value) {
                      _viewModel.setPassword(passwordController.text);
                    },
                    decoration: searchBarDecoration(emailFocusNode,
                        "Create a password", EvaIcons.lockOutline),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
