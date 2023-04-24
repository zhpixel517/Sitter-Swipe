// bio and other information
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitter_swipe/pages/register/pages.dart';
import 'package:sitter_swipe/pages/register/provider/button_state_provider.dart';
import 'package:sitter_swipe/pages/register/register_viewmodel.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/strings.dart';
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
  FocusNode genderFocusNode = FocusNode();
  Key formKey = GlobalKey<FormState>();
  TextEditingController bioController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  String? gender;

  @override
  void initState() {
    super.initState();
    bioController.text = _viewModel.userBio ?? "";
    addressController.text = _viewModel.userHomeAddress ?? "";
    genderController.text = _viewModel.userGender ?? "";
  }

  _checkBlur(BlurProvider provider) {
    if (bioController.text == "" ||
        addressController.text == "" ||
        genderController.text == "") {
      provider.blur();
    } else {
      provider.unblur();
    }
  }

  @override
  Widget build(BuildContext context) {
    final blurProvider = Provider.of<BlurProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkBlur(blurProvider);
    });
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            RegisterPageTitles.about,
            style: Fonts.bold,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.globalContentSidePadding),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppPadding.p5),
                    child: Text(
                      _viewModel.userIsSitter!
                          ? AppStrings.bioLabelForSitter
                          : AppStrings.bioLabelForParent,
                      textAlign: TextAlign.center,
                      style: Fonts.smallText,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppPadding.p10),
                    child: TextFormField(
                      controller: bioController,
                      onChanged: (string) {
                        _viewModel.setUserBio(string);
                        _checkBlur(blurProvider);
                      },
                      maxLines: 10,
                      decoration: globalInputDecoration(
                          bioFocusNode, "Bio", EvaIcons.personOutline),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppPadding.p5),
                    child: Text(
                      "Your bio will be displayed on your profile",
                      textAlign: TextAlign.center,
                      style: Fonts.smallText,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppPadding.p10),
                    child: TextFormField(
                      controller: addressController,
                      onChanged: (string) {
                        _viewModel.setAddress(string);
                        _checkBlur(blurProvider);
                      },
                      decoration: globalInputDecoration(addressFocusNode,
                          "Residence Address", EvaIcons.homeOutline),
                    ),
                  ),
                  Text(
                    "Your home address will NOT be displayed on your profile",
                    textAlign: TextAlign.center,
                    style: Fonts.smallText,
                  ),
                  Stack(children: [
                    TextFormField(
                      controller: genderController,
                      decoration: globalInputDecoration(genderFocusNode,
                          "Gender", Icons.transgender_outlined),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p18),
                      child: _genderDropDown(blurProvider),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ));
  }

  DropdownButtonHideUnderline _genderDropDown(BlurProvider provider) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
          icon: Container(),
          isExpanded: true,
          isDense: false,
          value: gender,
          items: [
            DropdownMenuItem(
              value: "Male",
              onTap: () {
                genderController.text = "Male";
                _viewModel.setGender("male");
                _checkBlur(provider);
              },
              child: const Text("Male"),
            ),
            DropdownMenuItem(
                value: "Female",
                onTap: () {
                  genderController.text = "Female";
                  _viewModel.setGender("female");
                  _checkBlur(provider);
                },
                child: const Text("Female")),
            DropdownMenuItem(
              value: "Other",
              onTap: () {
                genderController.text = "Other";
                _viewModel.setGender("any");
                _checkBlur(provider);
              },
              child: const Text("Other"),
            )
          ],
          onChanged: (val) {}),
    );
  }
}
