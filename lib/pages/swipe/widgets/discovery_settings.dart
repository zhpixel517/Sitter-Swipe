import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sitter_swipe/models/enums/prefferred_gender.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';

class GenderChip extends StatefulWidget {
  bool selected;
  PreferredGender preferredGender;
  IconData icon;
  GenderChip(
      {required this.preferredGender,
      required this.icon,
      this.selected = false,
      Key? key})
      : super(key: key);

  @override
  _GenderChipState createState() => _GenderChipState();
}

class _GenderChipState extends State<GenderChip> {
  String _getCorrectText(PreferredGender pg) {
    switch (pg) {
      case PreferredGender.male:
        return "Male";
      case PreferredGender.female:
        return "Female";
      case PreferredGender.any:
        return "Any/Other";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      avatar: Icon(
        widget.icon,
        color: Colors.white,
      ),
      disabledColor: TanPallete.creamWhite,
      selectedColor: TanPallete.tan,
      label: Text(
        _getCorrectText(widget.preferredGender),
        style: widget.selected
            ? const TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)
            : const TextStyle(fontSize: 15, color: Colors.white),
      ),
      selected: widget.selected,
      onSelected: (value) {
        setState(() {
          widget.selected = value;
        });
      },
    );
  }
}

// this does not work
dynamic showDiscoveryPreferences(BuildContext context, bool lookingForSitter) {
  // lookingFor Sitter will be true if the user is a parent looking to hire someone
  // temp vars for getting user inputted data, bring in from getPrefs
  // ! ex: int? range = getPrefs('range');
  int? range = 25;
  double? minimumRating = 3.5;
  PreferredGender preferredGender; // only if lookingForSitter is true
  int? minAge;
  int? maxage;
  return showModalBottomSheet(
      elevation: 6.0,
      useRootNavigator: true,
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
                            flex: 1,
                            child: Text(
                              "Discovery Settings",
                              style: Fonts.bold.copyWith(fontSize: 25),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Range - ${range.toString()} miles",
                                    style: Fonts.bold.copyWith(fontSize: 17)),
                                Slider(
                                  divisions: 300,
                                  max: 300.0,
                                  value: range!.toDouble(),
                                  activeColor: TanPallete.tan,
                                  onChanged: (value) {
                                    setState(() {
                                      range = value.round().toInt();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
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
                                        child: GenderChip(
                                      preferredGender: PreferredGender.any,
                                      icon: Icons.transgender,
                                      selected: any_other,
                                    )),
                                    Expanded(
                                        child: GenderChip(
                                      preferredGender: PreferredGender.male,
                                      icon: Icons.male,
                                      selected: male,
                                    )),
                                    Expanded(
                                        child: GenderChip(
                                      preferredGender: PreferredGender.female,
                                      icon: Icons.female,
                                      selected: female,
                                    ))
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Minimum Rating - $minimumRating",
                                  style: Fonts.bold.copyWith(fontSize: 17),
                                ),
                                Center(
                                  child: RatingBar.builder(
                                      initialRating: 3, //get preferences
                                      minRating: 1,
                                      allowHalfRating: true,
                                      itemBuilder: (context, index) {
                                        return const Icon(EvaIcons.star,
                                            color: Colors.amber);
                                      },
                                      onRatingUpdate: (rating) {
                                        setState(() {
                                          minimumRating = rating;
                                        });
                                      }),
                                )
                              ],
                            ),
                          )
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
