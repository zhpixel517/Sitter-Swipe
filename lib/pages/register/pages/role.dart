// profile role - sitter or parent/family
import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/register/pages.dart';
import 'package:sitter_swipe/pages/register/register_viewmodel.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/strings.dart';
import 'package:sitter_swipe/services/di.dart';

class Role extends StatefulWidget {
  const Role({super.key});

  @override
  State<Role> createState() => _RoleState();
}

class _RoleState extends State<Role> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();

  bool isSitter = false;
  bool isParent = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          RegisterPageTitles.role,
          style: Fonts.bold,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RadioListTile(
              value: isSitter,
              groupValue: isSitter,
              onChanged: (value) {
                isSitter = value!;
                _viewModel.setIsSitter(value);
              },
              activeColor: TanPallete.tan,
              title: const Text(AppStrings.imASitter),
            ),
            RadioListTile(
              value: isParent,
              groupValue: isSitter,
              onChanged: (value) {
                isSitter = value!;
                _viewModel.setIsSitter(value);
              },
              activeColor: TanPallete.tan,
              title: const Text(AppStrings.imAParent),
            ),
            /*
            ListTile(
              leading: Radio(
                value: isSitter,
                groupValue: isSitter,
                onChanged: (value) {},
              ),
              title: const Text("I'm a babysitter looking to sell my services"),
            ),
            ListTile(
              leading: Radio(
                value: isParent,
                groupValue: null,
                onChanged: (value) {},
              ),
              title: const Text("I'm a parent looking to hire a babysitter"),
            )
            */
          ],
        ),
      ),
    );
  }
}
