//swipe on families or babysitters
// part of baseScreen
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/app/constants.dart';
import 'package:sitter_swipe/pages/swipe/widgets/card_content.dart';
import 'package:sitter_swipe/pages/swipe/widgets/custom_icon_button.dart';
import 'package:sitter_swipe/pages/swipe/widgets/discovery_settings.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/routes.dart';
import 'package:sitter_swipe/resources/strings.dart';
import 'package:sitter_swipe/resources/theme.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({Key? key}) : super(key: key);

  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  final FocusNode searchBarFocusNode = FocusNode();
  List<SwipeItem> cards = [
    SwipeItem(
        content: const CardContent(
          rating: 4.2,
          hourlyRate: '17',
          image: edp445Image,
          fullName: "Smelvin",
          userName: "smelvin_1",
          age: "23",
          occupation: "Jobless freak",
          distance: "5",
        ),
        likeAction: () {}),
    SwipeItem(
      content: const CardContent(
        rating: 4.0,
        hourlyRate: '14',
        image: edp445Image,
        userName: "joe_mama_69",
        fullName: "Joe Mama",
        age: "55",
        occupation: "Retired",
        distance: "15",
      ),
    ),
    SwipeItem(
      content: const CardContent(
        rating: 5.0,
        hourlyRate: '20',
        image: edp445Image,
        userName: "chorb12",
        fullName: "Chorbius",
        age: "17",
        occupation: "Student",
        distance: "3",
      ),
    )
  ]; // need to get these from the viewmodel/firebase

  @override
  void initState() {
    super.initState();
    searchBarFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.globalContentSidePadding),
        child: Column(
          children: [
            Expanded(
              child: _buildTopBar(context),
            ),
            Expanded(
              child: _buildSearchBar(context),
            ),
            Expanded(
              flex: 7,
              child: Center(
                child: SwipeCards(
                  matchEngine: MatchEngine(swipeItems: cards),
                  onStackFinished: () {
                    print("the stack has finished!!!@");
                    return const Center(
                      child: Text(
                          "No more babysitters found. Change your search preferences?"),
                    );
                  },
                  itemBuilder: (item, index) {
                    return cards.isNotEmpty
                        ? cards[index].content
                        : const Center(
                            child: Text(
                                "No more sitters found. Try change your discovery preferences?"));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap:
              () {}, // open up location search and return a different city to search in
          // use provider maybe
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(AppStrings.location,
                      style: Fonts.smallText.copyWith(fontSize: 13)),
                  const Icon(
                    EvaIcons.arrowDown,
                    color: TanPallete.lightGrey,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(EvaIcons.pin, color: TanPallete.tan),
                  Text.rich(TextSpan(
                      text: "Franklin",
                      style: Fonts.swipeScreenLocationTitle
                          .copyWith(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: ", Tennessee",
                            style: Fonts.swipeScreenLocationTitle)
                      ]))
                ],
              )
            ],
          ),
        ),
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.notifications);
            },
            icon: const Icon(
              EvaIcons.bellOutline,
              color: TanPallete.darkGrey,
              size: AppSizes.largeIconSize,
            ))
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: TextField(
              focusNode: searchBarFocusNode,
              decoration: searchBarDecoration(
                  searchBarFocusNode, AppStrings.sitterSearch)),
        ),
        Expanded(
          flex: 3,
          child: CustomIconButton(() {
            // slide up sheet with discovery preferences?
            showDiscoveryPreferences(context, true); // true for now
          },
              const Icon(
                EvaIcons.settingsOutline,
                color: TanPallete.richBlack,
              ),
              const EdgeInsets.all(9.0)),
        ),
      ],
    );
  }
}
