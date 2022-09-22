import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:sitter_swipe/pages/chat/chat.dart';
import 'package:sitter_swipe/pages/interested/interested.dart';
import 'package:sitter_swipe/pages/swipe/swipe.dart';
import 'package:sitter_swipe/resources/theme.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<BaseScreen> {
  List<BottomNavigationBarItem> bottomNavigationbarItems = const [
    BottomNavigationBarItem(icon: Icon(FeatherIcons.home), label: ""),
    BottomNavigationBarItem(icon: Icon(FeatherIcons.heart), label: ""),
    BottomNavigationBarItem(icon: Icon(FeatherIcons.messageCircle), label: ""),
  ];

  List pages = const [SwipePage(), InterestedPage(), ChatPage()];

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
