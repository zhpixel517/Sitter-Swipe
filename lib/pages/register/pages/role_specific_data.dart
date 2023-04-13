// page where a parent can enter in information about theif child

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
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

class RoleSpecificInput extends StatefulWidget {
  const RoleSpecificInput({super.key});

  @override
  State<RoleSpecificInput> createState() => _RoleSpecificInputState();
}

class _RoleSpecificInputState extends State<RoleSpecificInput> {
  bool? isSitter;
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.userIsSitter! ? isSitter = true : isSitter = false;
  }

  @override
  Widget build(BuildContext context) {
    return isSitter!
        ? const SitterAvailabilityPage()
        : const ChildrenInfoPage();
  }
}

class ChildrenInfoPage extends StatefulWidget {
  const ChildrenInfoPage({super.key});

  @override
  State<ChildrenInfoPage> createState() => _ChildrenInfoPageState();
}

class _ChildrenInfoPageState extends State<ChildrenInfoPage> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  Map childData = {
    "2": {"age": "", "hobbies": ""},
    "1": {"age": 3, "hobbies": "play"}
  };

  @override
  void initState() {
    super.initState();
    // repopulate with saved data - how?
  }

  _saveChildData(String name, String age, String hobbies) {
    _viewModel.children![name] = {"age": age, "hobbies": hobbies};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          RegisterPageTitles.parentPageTitle,
          style: Fonts.bold,
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.globalContentSidePadding),
          child: ListView(
            children: [
              for (int i = 0; i <= childData.length; i++)
                ChildInfoCard(index: i + 1),
              TextButton.icon(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        Theme.of(context).splashColor),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    EvaIcons.personAddOutline,
                    color: TanPallete.tan,
                  ),
                  label: Text(
                    "Add another child",
                    style: Fonts.smallText.copyWith(color: TanPallete.tan),
                  ))
            ],
          )),
    );
  }
}

class SitterAvailabilityPage extends StatefulWidget {
  const SitterAvailabilityPage({super.key});

  @override
  State<SitterAvailabilityPage> createState() => _SitterAvailabilityPageState();
}

class _SitterAvailabilityPageState extends State<SitterAvailabilityPage> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  Key formKey = GlobalKey<FormState>();
  FocusNode availabilityFocusNode = FocusNode();
  TextEditingController availabilityTextController = TextEditingController();
  String? availability;

  _checkBlur(BlurProvider provider) {
    if (availabilityTextController.text == "") {
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
            RegisterPageTitles.sitterSpecificPageTitle,
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
                  child: Stack(
                    // this special trick makes it so I can make a textfield
                    // act like a drop down button
                    children: [
                      TextFormField(
                        controller: availabilityTextController,
                        decoration: globalInputDecoration(
                            availabilityFocusNode,
                            "Enter your availability",
                            EvaIcons.calendarOutline),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.globalContentSidePadding),
                        child: _availabilityDropDown(blurProvider),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Your availability will be publicly shown on your profile.",
                  textAlign: TextAlign.center,
                  style: Fonts.smallText,
                )
              ],
            ),
          ),
        ));
  }

  DropdownButtonHideUnderline _availabilityDropDown(BlurProvider provider) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
          icon: Container(), // no icon
          isExpanded: true,
          isDense: false,
          value: availability,
          items: [
            DropdownMenuItem(
              value: AppStrings.anyTimeOnWeekdays,
              onTap: () {
                availabilityTextController.text =
                    AppStrings.anyTimeOnWeekNights;
                _viewModel.setAvailability(AppStrings.anyTimeOnWeekdays);
                _checkBlur(provider);
              },
              child: const Text(AppStrings.anyTimeOnWeekdays),
            ),
            DropdownMenuItem(
              value: AppStrings.anyTimeOnWeekNights,
              onTap: () {
                availabilityTextController.text =
                    AppStrings.anyTimeOnWeekNights;
                _viewModel.setAvailability(AppStrings.anyTimeOnWeekNights);
                _checkBlur(provider);
              },
              child: const Text(AppStrings.anyTimeOnWeekNights),
            ),
            DropdownMenuItem(
              value: AppStrings.weekendsOnly,
              onTap: () {
                availabilityTextController.text = AppStrings.weekendsOnly;
                _viewModel.setAvailability(AppStrings.weekendsOnly);
                _checkBlur(provider);
              },
              child: const Text(AppStrings.weekendsOnly),
            ),
            DropdownMenuItem(
              value: AppStrings.anytime,
              onTap: () {
                availabilityTextController.text = AppStrings.anytime;
                _viewModel.setAvailability(AppStrings.anytime);
                _checkBlur(provider);
              },
              child: const Text(AppStrings.anytime),
            ),
          ],
          onChanged: (val) {}),
    );
  }
}

class ChildInfoCard extends StatelessWidget {
  final int? index;
  const ChildInfoCard({
    super.key,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p5),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: TanPallete.darkGrey),
            borderRadius: const BorderRadius.all(
                Radius.circular(AppSizes.elevatedButtonBorderRadius))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p10, vertical: AppPadding.p5),
              child: Text(
                "Child $index",
                style: Fonts.smallText,
                textAlign: TextAlign.start,
              ),
            ),
            // I only need blank focus nodes for now
            Padding(
              padding: const EdgeInsets.all(AppPadding.p5),
              child: TextFormField(
                decoration: globalInputDecoration(
                    FocusNode(), "Child's name", Icons.emoji_people_outlined),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p5),
              child: TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: globalInputDecoration(
                    FocusNode(), "Child's age", Icons.cake_outlined),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppPadding.p5, AppPadding.p5, AppPadding.p5, AppPadding.p10),
              child: TextFormField(
                  decoration: globalInputDecoration(
                      FocusNode(),
                      "Hobbies, favorite toy/activities...",
                      Icons.toys_outlined)),
            )
          ],
        ),
      ),
    );
  }
}
