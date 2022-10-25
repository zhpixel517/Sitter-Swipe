import 'package:flutter/material.dart';
import 'package:sitter_swipe/models/enums/prefferred_gender.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DiscoveryPreferences extends StatefulWidget {
  final PanelController controller;
  DiscoveryPreferences(this.controller, {Key? key}) : super(key: key);

  @override
  _DiscoveryPreferencesState createState() => _DiscoveryPreferencesState();
}

class _DiscoveryPreferencesState extends State<DiscoveryPreferences> {
  double? range = 0;
  PreferredGender preferredGender =
      PreferredGender.any; // only if lookingForSitter is true
  int? minAge;
  int? maxage;
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: widget.controller,
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "Discovery Settings",
                style: Fonts.bold,
              ),
            ),
            Expanded(
              child: Slider(
                label: "Range",
                max: 100.0,
                value: range!,
                activeColor: TanPallete.tan,
                onChanged: (value) {
                  setState(() {
                    range = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// this does not work
dynamic showDiscoveryPreferences(BuildContext context, bool lookingForSitter) {
  // lookingFor Sitter will be true if the user is a parent looking to hire someone
  // temp vars for getting user inputted data, bring in from getPrefs
  // ! ex: int? range = getPrefs('range');
  double? range = 0;
  PreferredGender preferredGender; // only if lookingForSitter is true
  int? minAge;
  int? maxage;
  return showModalBottomSheet(
      elevation: 6.0,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizes.searchBarBorderRadius),
              topRight: Radius.circular(AppSizes.searchBarBorderRadius))),
      // enableDrag: true, // must have an animation controller to use this
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return BottomSheet(
              enableDrag: false,
              // animationController: BottomSheet.createAnimationController(this),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.searchBarBorderRadius))),
              onClosing: () {
                savePreferences();
                print("closed");
              },
              builder: (context) {
                return StatefulBuilder(builder: (context, setState) {
                  bool any_other = true;
                  bool male = false;
                  bool female = false;
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(
                          AppPadding.globalContentSidePadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Discovery Settings",
                              style: Fonts.bold.copyWith(fontSize: 25),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Range - ${range.toString()} miles",
                                    style: Fonts.bold.copyWith(fontSize: 17)),
                                Slider(
                                  divisions: 300,
                                  label: "Range",
                                  max: 300.0,
                                  value: range!,
                                  activeColor: TanPallete.tan,
                                  onChanged: (value) {
                                    setState(() {
                                      range = value.round().toDouble();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Preffered Gender",
                                  style: Fonts.bold.copyWith(fontSize: 17),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: ChoiceChip(
                                        avatar: const Icon(Icons.transgender),
                                        disabledColor: TanPallete.creamWhite,
                                        selectedColor: TanPallete.tan,
                                        label: const Text("Any/Other"),
                                        selected: any_other,
                                        onSelected: (value) {
                                          setState(() {
                                            any_other = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: ChoiceChip(
                                        avatar: const Icon(Icons.male),
                                        disabledColor: TanPallete.creamWhite,
                                        selectedColor: TanPallete.tan,
                                        label: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            "Male",
                                            style: Fonts.bold
                                                .copyWith(fontSize: 15),
                                          ),
                                        ),
                                        selected: male,
                                        onSelected: (value) {
                                          setState(() {
                                            male = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: ChoiceChip(
                                        avatar: const Icon(Icons.female),
                                        disabledColor: TanPallete.creamWhite,
                                        selectedColor: TanPallete.tan,
                                        label: const Text("Female"),
                                        selected: female,
                                        onSelected: (value) {
                                          setState(() {
                                            female = value;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              });
        });
      });
}

void savePreferences() {
  // save the discovery preferences
  // ! Provider to rebuild with new changes
  // ! app preferences to make sure their choices are saved next time
}
