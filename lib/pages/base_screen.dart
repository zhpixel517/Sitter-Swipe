import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/chat/chat.dart';
import 'package:sitter_swipe/pages/interested/interested.dart';
import 'package:sitter_swipe/pages/profile/profile.dart';
import 'package:sitter_swipe/pages/swipe/swipe.dart';
import 'package:sitter_swipe/resources/theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

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

  List pages = const [SwipePage(), InterestedPage(), ChatPage(), ProfilePage()];

  int _selectedIndex = 0;

  void _updateIndex(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getBottomNavigationBarTheme(
          bottomNavigationbarItems, _selectedIndex, _updateIndex),
      body: pages[_selectedIndex],
    );
  }
}
