// someone else's profile that you tap on
// come here from the swipe screen
// use a hero animation?

import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sitter_swipe/app/constants.dart';
import 'package:sitter_swipe/models/child.dart';
import 'package:sitter_swipe/pages/base_screen.dart';
import 'package:sitter_swipe/pages/chat/chat.dart';
import 'package:sitter_swipe/pages/onboarding/widgets/onboarding_page.dart';
import 'package:sitter_swipe/pages/swipe/swipe.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/routes.dart';
import 'package:sitter_swipe/resources/strings.dart';
import 'package:sitter_swipe/services/responsive.dart';

class UserProfile extends StatefulWidget {
  // what kinds of data points do I need to pass through?
  // retreive hobbies and other relevent profile data when coming from the swipe screen
  String? userName; // send to firebase
  // cache the profile image first.
  String? fullName;
  bool isSelf;
  bool isFamily; // is a group of children
  bool? didComeFromInterestedScreen;
  int? indexFromInterestedScreen;
  bool? didComeFromRegisteredScreen;
  final List<String>? profileImages;
  final String? age;
  final String? bio;
  //final MatchEngine? matchEngineInstance;
  UserProfile(
      this.userName, this.fullName, this.isSelf, this.isFamily, this.age,
      {required this.profileImages,
      this.bio,
      this.didComeFromInterestedScreen,
      this.indexFromInterestedScreen,
      required this.didComeFromRegisteredScreen,
      /*this.matchEngineInstance*/ Key? key})
      : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List<String> listPopUpOptions = ["Block", "Report"];
  Brightness statusBarBrightness = Brightness.light;
  int? carouselIndex = 0;

  @override
  void initState() {
    super.initState();

    //TODO: either pull data from firebase or use cached data to populate this bit if self
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    //var width = MediaQuery.of(context).size.width;
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft:
                            Radius.circular(AppSizes.searchBarBorderRadius),
                        bottomRight:
                            Radius.circular(AppSizes.searchBarBorderRadius)),
                    child: Stack(
                      children: [
                        CarouselSlider(
                            items: List.generate(widget.profileImages!.length,
                                (index) {
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  widget.didComeFromRegisteredScreen!
                                      ? Image(
                                          image: FileImage(File(
                                              widget.profileImages![index])),
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        )
                                      : Image(
                                          image: NetworkImage(
                                              widget.profileImages![index]),
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        ),
                                  imageBlur(constraints),
                                ],
                              );
                            }),
                            options: CarouselOptions(
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    carouselIndex = index;
                                  });
                                },
                                height: double.infinity,
                                viewportFraction: 1,
                                enableInfiniteScroll: false)),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: AppPadding.p10),
                            child: DotsIndicator(
                              position: carouselIndex!.toDouble(),
                              dotsCount: widget.profileImages!.length,
                              decorator: const DotsDecorator(
                                  activeColor: Colors.white,
                                  color: TanPallete.darkGrey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.globalContentSidePadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: widget.didComeFromRegisteredScreen == false
                              ? []
                              : widget.isSelf
                                  ? [
                                      _customTopIconButton(EvaIcons.settings,
                                          () {
                                        Navigator.pushNamed(
                                            context, Routes.settings);
                                      })
                                    ]
                                  : [
                                      _customTopIconButton(EvaIcons.arrowBack,
                                          () {
                                        Navigator.pop(context);
                                      }),
                                      CircleAvatar(
                                        backgroundColor: TanPallete.tan,
                                        child: PopupMenuButton(
                                            icon: const Icon(
                                              EvaIcons.moreVertical,
                                              color: Colors.white,
                                            ),
                                            itemBuilder: ((context) {
                                              return listPopUpOptions
                                                  .map((String item) =>
                                                      PopupMenuItem(
                                                        textStyle:
                                                            Fonts.mediumStyle,
                                                        value: item,
                                                        child: Text(item),
                                                      ))
                                                  .toList();
                                            })),
                                      )
                                    ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.globalContentSidePadding,
                        vertical: AppPadding.p10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.fullName!,
                          style: Fonts.bold
                              .copyWith(color: Colors.white, fontSize: 25),
                        ),
                        Text(widget.userName!,
                            style: Fonts.smallText.copyWith(fontSize: 15))
                      ],
                    ),
                  )
                ],
              ),
            ),
            widget.isSelf
                ? const SizedBox(height: 0, width: 0)
                : Padding(
                    padding: const EdgeInsets.fromLTRB(
                        AppPadding.globalContentSidePadding,
                        AppPadding.globalContentSidePadding,
                        AppPadding.globalContentSidePadding,
                        0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildProfileActionButton(
                            EvaIcons.close, ButtonLabels.pass, () async {
                          Navigator.pop(context);
                          await Future.delayed(
                              const Duration(milliseconds: 100), () {});
                          SwipePageState.matchEngine!.currentItem!.nope();
                          // update firebase?
                        }),
                        _buildProfileActionButton(
                            EvaIcons.heart, ButtonLabels.like, () async {
                          if (widget.didComeFromInterestedScreen == true &&
                              widget.indexFromInterestedScreen != null) {
                            Navigator.pop(
                                context, widget.indexFromInterestedScreen);
                          } else {
                            Navigator.pop(context);
                          }
                          await Future.delayed(
                              const Duration(milliseconds: 100), () {});
                          SwipePageState.matchEngine!.currentItem!.like();
                          // update firebase?
                        }),
                        _buildProfileActionButton(
                            EvaIcons.messageCircle, ButtonLabels.message, () {
                          final BottomNavigationBar navigationBar = BaseScreen
                              .globalKey.currentWidget as BottomNavigationBar;
                          navigationBar.onTap!(Routes.messagesIndex);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ChatPage(
                              widget.userName,
                              true,
                              name: widget.fullName,
                              profileImageLocator: widget.profileImages![0],
                            );
                          }));
                        }),
                      ],
                    ),
                  ),
            Padding(
              padding:
                  const EdgeInsets.all(AppPadding.globalContentSidePadding),
              child: Container(
                decoration: const BoxDecoration(
                    color: TanPallete.creamWhite,
                    borderRadius: BorderRadius.all(
                        Radius.circular(AppSizes.searchBarBorderRadius))),
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p10),
                  child: Column(
                    children: [
                      widget.isSelf
                          ? const SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    // instead of "3", pull number of kids
                                    Text(widget.isFamily ? "3" : widget.age!,
                                        style: Fonts.bold.copyWith(
                                            fontSize: SizeConfig
                                                    .safeBlockHorizontal! *
                                                8)),
                                    Text(widget.isFamily ? "Children" : "Age",
                                        style: Fonts.smallText),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "5 mi.",
                                      style: Fonts.bold.copyWith(
                                          fontSize:
                                              SizeConfig.safeBlockHorizontal! *
                                                  8),
                                    ),
                                    Text(
                                      "Distance",
                                      style: Fonts.smallText,
                                    )
                                  ],
                                ),
                              ],
                            ),
                      SizedBox(
                        height: widget.isSelf ? 0 : 15,
                      ),
                      Text(
                        //"This is a Sitter Swipe Bio. I'm thinking that prospective babysitters or families as well can decide what they want to write here here.",
                        widget.bio ?? "Blank bio!",
                        style: Fonts.mediumStyle
                            .copyWith(color: TanPallete.richBlack),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.all(AppPadding.globalContentSidePadding),
              child: Container(
                decoration: const BoxDecoration(
                    color: TanPallete.creamWhite,
                    borderRadius: BorderRadius.all(
                        Radius.circular(AppSizes.searchBarBorderRadius))),
                child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Children",
                          style: Fonts.mediumStyle,
                        ),
                        //TODO: make a query about their kids
                      ],
                    )),
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.all(AppPadding.globalContentSidePadding),
                child: Column(
                  children: [
                    Center(
                        child: Text(
                      "4.7",
                      style: Fonts.bold.copyWith(
                          fontSize: SizeConfig.safeBlockHorizontal! * 8),
                    )),
                    RatingBarIndicator(
                      unratedColor: TanPallete.creamWhite,
                      rating: 4.7,
                      itemBuilder: (context, index) => const Icon(
                        EvaIcons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 30.0, // get rating from firebase
                    ),
                    Center(
                      child: Text("5 Reviews",
                          style: Fonts.smallText.copyWith(
                              fontSize: SizeConfig.safeBlockHorizontal! * 3.5)),
                    ),
                  ],
                )),
          ],
        ),
      );
    }));
  }

  Widget _customTopIconButton(IconData icon, Function callback) {
    return CircleAvatar(
      backgroundColor: TanPallete.tan,
      child: IconButton(
          onPressed: () {
            callback();
          },
          icon: Icon(
            icon,
            color: Colors.white,
          )),
    );
  }

  Widget _buildProfileActionButton(
      IconData icon, String text, Function callback) {
    return Expanded(
      child: Column(
        children: [
          IconButton(
            onPressed: () {
              callback();
            },
            icon: Icon(
              icon,
              color: TanPallete.tan,
              size: 35.0,
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: Fonts.smallText,
          )
        ],
      ),
    );
  }
}
