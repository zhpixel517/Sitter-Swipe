import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sitter_swipe/app/constants.dart';
import 'package:sitter_swipe/pages/chat/chat_selection.dart';
import 'package:sitter_swipe/pages/interested/interested.dart';
import 'package:sitter_swipe/pages/profile/profile.dart';
import 'package:sitter_swipe/pages/swipe/swipe.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:sitter_swipe/services/responsive.dart';
import 'package:sitter_swipe/services/storage.dart';

class BaseScreen extends StatefulWidget {
  int screenIndex; // starts with 0
  static GlobalKey globalKey = GlobalKey();
  // ! Did this so that I can come to certain spots from the notification screen
  BaseScreen({this.screenIndex = 0, Key? key}) : super(key: key);
  @override
  _BaseScreen createState() => _BaseScreen();
}

class _BaseScreen extends State<BaseScreen> {
  List<BottomNavigationBarItem> bottomNavigationbarItems = const [
    BottomNavigationBarItem(
        icon: Icon(EvaIcons.homeOutline),
        label: "",
        activeIcon: Icon(EvaIcons.home)),
    BottomNavigationBarItem(
        icon: Icon(EvaIcons.heartOutline),
        label: "",
        activeIcon: Icon(EvaIcons.heart)),
    BottomNavigationBarItem(
        icon: Icon(EvaIcons.messageCircleOutline),
        label: "",
        activeIcon: Icon(EvaIcons.messageCircle)),
    BottomNavigationBarItem(
        icon: Icon(EvaIcons.personOutline),
        label: "",
        activeIcon: Icon(EvaIcons.person))
  ];

  List pages = [
    const SwipePage(),
    const InterestedPage(),
    const ChatSelection(),
    UserProfile("Zachary", "Zachary", true, false, "18",
        didComeFromRegisteredScreen: false,
        profileImages: const [
          boy2,
          boy1,
          edp445Image,
          girl1,
          girl2,
          girl3
        ]) // TODO: get profile data here from firebase
  ];

  void updateIndex(int newIndex) {
    HapticFeedback.selectionClick();
    setState(() {
      widget.screenIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBarTheme(
          data: const BottomNavigationBarThemeData(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0,
              unselectedIconTheme: IconThemeData(
                  color: TanPallete.darkGrey, size: AppSizes.largeIconSize),
              selectedIconTheme:
                  IconThemeData(color: TanPallete.tan, size: 40.0)),
          child: BottomNavigationBar(
              key: BaseScreen.globalKey,
              items: bottomNavigationbarItems,
              currentIndex: widget.screenIndex,
              onTap: updateIndex)),
      body: pages[widget.screenIndex],
    );
  }
}
