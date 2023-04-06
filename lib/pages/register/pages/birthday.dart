// ask for user's birthday and calculate their age
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/register/pages.dart';
import 'package:sitter_swipe/pages/register/register_viewmodel.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/theme.dart';
import 'package:sitter_swipe/services/di.dart';

class Birthday extends StatefulWidget {
  const Birthday({super.key});

  @override
  State<Birthday> createState() => _BirthdayState();
}

class _BirthdayState extends State<Birthday> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  Key formKey = GlobalKey<FormState>();
  FocusNode birthdayFocusNode = FocusNode();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = _viewModel.userDateOfBirth != null
        ? _dateOfBirthToString(_viewModel.userDateOfBirth)
        : "";
  }

  String _dateOfBirthToString(DateTime? pickedDate) {
    return "${pickedDate!.month}/${pickedDate.day}/${pickedDate.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            RegisterPageTitles.age,
            style: Fonts.bold,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.globalContentSidePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
                child: Form(
                    child: TextFormField(
                  controller: dateController,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        initialDatePickerMode: DatePickerMode.year,
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime(
                            1920), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime.now());
                    dateController.text = _dateOfBirthToString(pickedDate);
                    _viewModel.userDateOfBirth = pickedDate;
                  },
                  decoration: searchBarDecoration(birthdayFocusNode,
                      "Date of birth", EvaIcons.calendarOutline),
                )),
              ),
              Text(
                "Your age will be shown on your profile",
                textAlign: TextAlign.center,
                style: Fonts.smallText,
              )
            ],
          ),
        ));
  }
}
