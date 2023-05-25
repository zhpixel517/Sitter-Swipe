//swipe on families or babysitters
// part of baseScreen

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/swipe/swipe_viewmodel.dart';
import 'package:sitter_swipe/pages/swipe/widgets/card_content.dart';
import 'package:sitter_swipe/pages/swipe/widgets/custom_icon_button.dart';
import 'package:sitter_swipe/pages/swipe/widgets/discovery_settings.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/routes.dart';
import 'package:sitter_swipe/resources/strings.dart';
import 'package:sitter_swipe/resources/theme.dart';
import 'package:stacked/stacked.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../services/di.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({Key? key}) : super(key: key);

  @override
  SwipePageState createState() => SwipePageState();
}

class SwipePageState extends State<SwipePage> {
  final FocusNode searchBarFocusNode = FocusNode();

  List<SwipeItem> familyCards = [
    SwipeItem(
        content: const CardContent(
            image: "assets/images/family1.png",
            userName: "@the_lees",
            fullName: "The Lees",
            age: "",
            rating: 4.6,
            distance: "2",
            hourlyRate: "13",
            isFamily: true,
            alignment: Alignment.center)),
    SwipeItem(
        content: const CardContent(
            image: "assets/images/family2.png",
            userName: "@the_lees",
            fullName: "The Reindls",
            age: "",
            rating: 4.6,
            distance: "2",
            hourlyRate: "13",
            isFamily: true,
            alignment: Alignment.center)),
  ];

  List<SwipeItem> cards = [
    SwipeItem(
      content: const CardContent(
        alignment: Alignment.center,
        rating: 5.0,
        hourlyRate: '20',
        image: "assets/images/sitter3.png", //ImageAssets.cummins,
        userName: "@tony_pepperoni",
        fullName: "Tony",
        age: "15",
        isFamily: false,
        distance: "3",
      ),
    ),
    SwipeItem(
        content: const CardContent(
          alignment: Alignment.topCenter,
          rating: 4.2,
          hourlyRate: '17',
          image: "assets/images/sitter1.png",

          ///girl1, //ImageAssets.chilton,
          fullName: "Alice",
          userName: "chilton9000",
          age: "20",
          isFamily: false,
          distance: "5",
        ),
        likeAction: () {}),
    SwipeItem(
      content: const CardContent(
        alignment: Alignment.centerRight,
        rating: 4.0,
        hourlyRate: '14',
        image: "assets/images/sitter2.png", //ImageAssets.cleaver,
        userName: "jennyRocks",
        fullName: "Jennifer",
        age: "21",
        isFamily: false,
        distance: "15",
      ),
    ),
    SwipeItem(
      content: const CardContent(
        alignment: Alignment.center,
        rating: 5.0,
        hourlyRate: '20',
        image: "assets/images/sitter4.png", //ImageAssets.qualls,
        userName: "scrambled_brain",
        fullName: "Bianca",
        age: "19",
        isFamily: false,
        distance: "3",
        // matchEngineInstance: matchEngine,
      ),
    ),
    /*
    SwipeItem(
      content: CardContent(
        alignment: Alignment.center,
        rating: 5.0,
        hourlyRate: '20',
        image: ImageAssets.schneider,
        userName: "momma_bear",
        fullName: "Kris Schneider",
        age: "23",
        isFamily: false,
        distance: "3",
        // matchEngineInstance: matchEngine,
      ),
    ),
    */
  ]; // need to get these from the viewmodel/firebase

/*
  Widget _returnCorrectSwipeIndicator(SlideRegion? slideRegion) {
    setState(() {
      switch (slideRegion) {
        case SlideRegion.inNopeRegion:
          return Center(
              child: Text(
            "TESTING!!!!",
            style: Fonts.bold.copyWith(color: Colors.white),
          ));
        case SlideRegion.inLikeRegion:
          return Center(
              child: Text(
            "TESTING!!!!",
            style: Fonts.bold.copyWith(color: Colors.white),
          ));

        case SlideRegion.inSuperLikeRegion:
          return Center(
              child: Text(
            "TESTING!!!!",
            style: Fonts.bold.copyWith(color: Colors.white),
          ));
        default:
          return Center(
              child: Text(
            "TESTING!!!!",
            style: Fonts.bold.copyWith(color: Colors.white),
          ));
      }
    });
  }
  */

  final SwipeViewModel _viewModel = instance<SwipeViewModel>();
  static MatchEngine? matchEngine;

  @override
  void initState() {
    super.initState();
    _viewModel.start();
    searchBarFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    matchEngine = MatchEngine(swipeItems: cards);
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
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
                    child: ViewModelBuilder<SwipeViewModel>.reactive(
                        viewModelBuilder: () => SwipeViewModel(),
                        builder: (context, model, child) {
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      EvaIcons.questionMarkCircleOutline,
                                      size: 30,
                                      color: TanPallete.lightGrey,
                                    ),
                                  ),
                                  Text(
                                    AppStrings.noMoreSitters,
                                    style: Fonts.mediumStyle
                                        .copyWith(color: TanPallete.lightGrey),
                                  ),
                                  const SizedBox(height: 30),
                                  ElevatedButton(
                                      onPressed: () {
                                        showDiscoveryPreferences(context, true);
                                      },
                                      child: const Text(
                                          "Change Discovery Settings"))
                                ],
                              ),
                              SwipeCards(
                                  upSwipeAllowed: false,
                                  matchEngine: matchEngine!,
                                  onStackFinished: () {},
                                  itemBuilder: (item, index) {
                                    return cards.isNotEmpty
                                        ? cards[index].content
                                        : const Center(
                                            child: Text(
                                                "No more sitters found. Try change your discovery preferences?"));
                                  })
                            ],
                          );
                        })),
              ),
            ],
          ),
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
                  StreamBuilder(
                      stream: _viewModel.outputCityName,
                      builder: (context, snapshotCityName) {
                        return StreamBuilder(
                            stream: _viewModel.outputStateProvinceName,
                            builder: (context, snapshotStateName) {
                              if (!snapshotCityName.hasData &&
                                  !snapshotStateName.hasData) {
                                return Text("Getting Location...",
                                    style: Fonts.swipeScreenLocationTitle
                                        .copyWith(fontSize: 8));
                              } else {
                                return Text.rich(TextSpan(
                                    text: snapshotCityName.data + ", ",
                                    style: Fonts.swipeScreenLocationTitle
                                        .copyWith(fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                          text: snapshotStateName.data,
                                          style: Fonts.swipeScreenLocationTitle)
                                    ]));
                              }
                            });
                      })
                ],
              )
            ],
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p5),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.broadcast);
                },
                icon: const Icon(
                  Icons.settings_input_antenna,
                  color: TanPallete.darkGrey,
                  size: AppSizes.largeIconSize,
                ),
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
        ),
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
              decoration: globalInputDecoration(searchBarFocusNode,
                  AppStrings.sitterSearch, EvaIcons.search)),
        ),
        Expanded(
          flex: 3,
          child: CustomIconButton(() {
            // slide up sheet with discovery preferences?
            showDiscoveryPreferences(context, true); // true for now
          },
              const Icon(
                EvaIcons.settingsOutline,
                color: Colors.white,
              ),
              const EdgeInsets.all(9.0)),
        ),
      ],
    );
  }
}
