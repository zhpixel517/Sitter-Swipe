// profile role - sitter or parent/family
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitter_swipe/pages/register/pages.dart';
import 'package:sitter_swipe/pages/register/provider/button_state_provider.dart';
import 'package:sitter_swipe/pages/register/register_viewmodel.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/strings.dart';
import 'package:sitter_swipe/resources/theme.dart';
import 'package:sitter_swipe/services/di.dart';

class Role extends StatefulWidget {
  const Role({super.key});

  @override
  State<Role> createState() => _RoleState();
}

class _RoleState extends State<Role> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  FocusNode rateFocusNode = FocusNode();
  TextEditingController rateTextController = TextEditingController();

  bool _isSitterSelected = false;
  bool _isParentSelected = false;

  @override
  void initState() {
    super.initState();
    if (_viewModel.userIsSitter != null) {
      _viewModel.userIsSitter!
          ? _isSitterSelected = true
          : _isParentSelected = true;
    }
    rateTextController.text = _viewModel.sitterChargeRate ?? "";
  }

  _checkBlur(BlurProvider provider) {
    if (_isSitterSelected == false && _isParentSelected == false ||
        (_isParentSelected == true && rateTextController.text == '')) {
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          RegisterPageTitles.role,
          style: Fonts.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.globalContentSidePadding),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom:
                      MediaQuery.of(context).viewInsets.bottom > 0 ? 100 : 0),
              // if the keyboard is open, that means that the two toggle buttons gotta move up more
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildRoleChoiceButton(_isSitterSelected, () {
                    setState(() {
                      _isSitterSelected = true;
                      _isParentSelected = false;
                      _viewModel.setIsSitter(true);
                    });
                  }, AppStrings.imASitter, Icons.emoji_people_rounded),
                  _buildRoleChoiceButton(_isParentSelected, () {
                    setState(() {
                      _isSitterSelected = false;
                      _isParentSelected = true;
                      _viewModel.setIsSitter(false);
                    });
                  }, AppStrings.imAParent, Icons.family_restroom),
                ],
              ),
            ),
            _isParentSelected
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppPadding.p10),
                        child: Text(
                          "Enter the hourly rate you're willing to pay a potential babysitter. This will be shown on your profile.",
                          style: Fonts.smallText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      TextFormField(
                        controller: rateTextController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _viewModel.setRate(value);
                          _checkBlur(blurProvider);
                        },
                        decoration: globalInputDecoration(
                            rateFocusNode, "Rate", Icons.attach_money),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

_buildRoleChoiceButton(bool value, Function onTap, String text, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
    child: Container(
      height: 80, //! This may not be responsive to screen size changes
      decoration: BoxDecoration(
          color: value ? TanPallete.tan : TanPallete.creamWhite,
          borderRadius: const BorderRadius.all(
              Radius.circular(AppSizes.searchBarBorderRadius))),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p5, horizontal: AppPadding.p10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: Icon(
                  icon,
                  color: value ? Colors.white : TanPallete.darkGrey,
                  size: Fonts.bold.fontSize,
                ),
              ),
              Expanded(
                flex: 8,
                child: Text(text,
                    style: value
                        ? Fonts.secondaryFont.copyWith(color: Colors.white)
                        : Fonts.secondaryFont
                            .copyWith(color: TanPallete.darkGrey)),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
