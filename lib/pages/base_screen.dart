import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sitter_swipe/pages/chat/chat_selection.dart';
import 'package:sitter_swipe/pages/interested/interested.dart';
import 'package:sitter_swipe/pages/profile/profile.dart';
import 'package:sitter_swipe/pages/swipe/swipe.dart';
import 'package:sitter_swipe/resources/theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:sitter_swipe/services/storage.dart';

class BaseScreen extends StatefulWidget {
  int screenIndex = 0; // starts with 0
  // ! Did this so that I can come to certain spots from the notification screen
  BaseScreen({Key? key}) : super(key: key);

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
    UserProfile(ThisUser.name, ThisUser.name, true)
  ];

  void _updateIndex(int newIndex) {
    HapticFeedback.selectionClick();
    setState(() {
      widget.screenIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: getBottomNavigationBarTheme(
          bottomNavigationbarItems, widget.screenIndex, _updateIndex),
      body: pages[widget.screenIndex],
    );
  }
}
