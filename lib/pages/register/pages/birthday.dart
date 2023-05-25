// ask for user's birthday and calculate their age
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitter_swipe/pages/register/pages.dart';
import 'package:sitter_swipe/pages/register/provider/button_state_provider.dart';
import 'package:sitter_swipe/pages/register/register_viewmodel.dart';
import 'package:sitter_swipe/resources/colors.dart';
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
    return "${pickedDate?.month}/${pickedDate?.day}/${pickedDate?.year}";
  }

  _checkBlur(BlurProvider provider) {
    if (dateController.text == "") {
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
                        lastDate: DateTime.now(),
                        builder: ((context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary:
                                    TanPallete.tan, // header background color
                                onPrimary: Colors.white, // header text color
                                onSurface:
                                    TanPallete.darkGrey, // body text color
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                      TanPallete.tan, // button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        }));
                    dateController.text = _dateOfBirthToString(pickedDate);
                    _viewModel.userDateOfBirth = pickedDate;
                    _checkBlur(blurProvider);
                  },
                  decoration: globalInputDecoration(
                      birthdayFocusNode, "Date of birth", Icons.cake_outlined),
                )),
              ),
              Text(
                _viewModel.userIsSitter!
                    ? "Your age will be shown on your profile"
                    : "We need this to help verify your identity. This won't be shown on your profile.",
                textAlign: TextAlign.center,
                style: Fonts.smallText,
              )
            ],
          ),
        ));
  }
}
