// someone else's profile that you tap on
// come here from the swipe screen
// use a hero animation?

import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sitter_swipe/app/constants.dart';
import 'package:sitter_swipe/pages/base_screen.dart';
import 'package:sitter_swipe/pages/chat/chat.dart';
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
  final String? profileImage;
  final String? age;
  UserProfile(
      this.userName, this.fullName, this.isSelf, this.isFamily, this.age,
      {required this.profileImage, Key? key})
      : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List<String> listPopUpOptions = ["Call", "Block", "Report"];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft:
                            Radius.circular(AppSizes.searchBarBorderRadius),
                        bottomRight:
                            Radius.circular(AppSizes.searchBarBorderRadius)),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image(
                          // put a carousel here with multiple images
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          image: NetworkImage(widget.profileImage!),
                        ),
                        imageBlur()
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
                          children: widget.isSelf
                              ? [
                                  _customTopIconButton(EvaIcons.settings, () {
                                    Navigator.pushNamed(
                                        context, Routes.settings);
                                  })
                                ]
                              : [
                                  _customTopIconButton(EvaIcons.arrowBack, () {
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
                            EvaIcons.close, ButtonLabels.pass, () {}),
                        _buildProfileActionButton(
                            EvaIcons.heart, ButtonLabels.like, () async {
                          Navigator.pop(context);
                          await Future.delayed(const Duration(seconds: 1), () {
                            print("timer finsihed");
                          });
                          _simulateSwipe(SwipeDirection.left, width, height);
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
                              profileImageLocator: widget.profileImage,
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
                                    Text(widget.age!,
                                        style: Fonts.bold.copyWith(
                                            fontSize: SizeConfig
                                                    .safeBlockHorizontal! *
                                                8)),
                                    Text("Age", style: Fonts.smallText),
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
                        "This is a Sitter Swipe Bio. I'm thinking that prospective babysitters or families as well can decide what they want to write here here.",
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

  _simulateSwipe(SwipeDirection direction, var width, var height) {
    print("called simulate swipe!");
    WidgetsBinding.instance.handlePointerEvent(
        PointerDownEvent(pointer: 0, position: Offset(width / 2, height / 2)));
    WidgetsBinding.instance.handlePointerEvent(PointerMoveEvent(
      pointer: 0,
      //timeStamp: Duration(seconds:10),
      position: Offset(height / 2, width / 2 + 100),
      // delta: Offset(-10,Get.height/2),
      // distanceMax: 0.05,
    ));
    WidgetsBinding.instance.handlePointerEvent(
      const PointerUpEvent(pointer: 0),
    );
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

enum SwipeDirection { left, right }
