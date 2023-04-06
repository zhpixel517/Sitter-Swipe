// bio and other information
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/register/pages.dart';
import 'package:sitter_swipe/pages/register/register_viewmodel.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/theme.dart';
import 'package:sitter_swipe/services/di.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  FocusNode bioFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  Key formKey = GlobalKey<FormState>();
  TextEditingController bioController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            RegisterPageTitles.about,
            style: Fonts.bold,
          ),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.globalContentSidePadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p5),
                  child: Text(
                    "Enter a short bio about you. Be sure to mention your experience, hobbies, where you live, etc...",
                    textAlign: TextAlign.center,
                    style: Fonts.smallText,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
                  child: TextFormField(
                    controller: bioController,
                    onChanged: (string) {
                      _viewModel.setUserBio(string);
                    },
                    maxLines: 10,
                    decoration: searchBarDecoration(
                        bioFocusNode, "Bio", EvaIcons.personOutline),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p5),
                  child: Text(
                    "Your bio will be displayed on your profile",
                    textAlign: TextAlign.center,
                    style: Fonts.smallText,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
                  child: TextFormField(
                    controller: addressController,
                    onChanged: (string) {
                      _viewModel.setAddress(string);
                    },
                    decoration: searchBarDecoration(
                        addressFocusNode, "Home Address", EvaIcons.homeOutline),
                  ),
                ),
                Text(
                  "Your home address will NOT be displayed on your profile",
                  textAlign: TextAlign.center,
                  style: Fonts.smallText,
                )
              ],
            ),
          ),
        ));
  }
}
