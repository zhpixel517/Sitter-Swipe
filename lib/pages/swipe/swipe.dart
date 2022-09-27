//swipe on families or babysitters
// part of baseScreen

import 'dart:collection';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/swipe/widgets/card_content.dart';
import 'package:sitter_swipe/pages/swipe/widgets/custom_icon_button.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/strings.dart';
import 'package:sitter_swipe/resources/theme.dart';
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
          image:
              "https://img.itch.zone/aW1nLzgxMzEyOTguanBn/315x250%23c/9yD9hv.jpg",
          fullName: "Smelvin",
          userName: "smelvin_1",
          age: "23",
          occupation: "Jobless freak",
          distance: "5",
        ),
        likeAction: () {}),
    SwipeItem(
      content: const CardContent(
        image:
            "https://img.itch.zone/aW1nLzgxMzEyOTguanBn/315x250%23c/9yD9hv.jpg",
        userName: "joe_mama_69",
        fullName: "Joe Mama",
        age: "55",
        occupation: "Retired",
        distance: "15",
      ),
    ),
    SwipeItem(
      content: const CardContent(
        image:
            "https://img.itch.zone/aW1nLzgxMzEyOTguanBn/315x250%23c/9yD9hv.jpg",
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
                    return cards[index].content;
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
                      style: Fonts.swipeScreenLocationTitle,
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
            onPressed: () {},
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
          child: CustomIconButton(
              () {},
              const Icon(
                EvaIcons.settingsOutline,
                color: Colors.white,
              ),
              const EdgeInsets.all(12.0)),
        ),
      ],
    );
  }
}
