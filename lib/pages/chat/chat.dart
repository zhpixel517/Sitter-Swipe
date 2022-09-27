// messaging
// part of baseScreen

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/chat/chat_viewmodel.dart';
import 'package:sitter_swipe/pages/login/login.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/strings.dart';
import 'package:sitter_swipe/resources/theme.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatViewModel _viewModel = instance<ChatViewModel>();
  final FocusNode messageSearchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    messageSearchFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(PageTitles.chat),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.globalContentSidePadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                  focusNode: messageSearchFocusNode,
                  decoration: searchBarDecoration(
                      messageSearchFocusNode, AppStrings.messageSearch)),
              Column(
                children: const [
                  ListTile(
                    leading: CircleAvatar(),
                    title: Text("New message from so and so"),
                  ),
                  ListTile(
                    leading: CircleAvatar(),
                    title: Text("New message from so and so"),
                  ),
                  ListTile(
                    leading: CircleAvatar(),
                    title: Text("New message from so and so"),
                  ),
                  ListTile(
                    leading: CircleAvatar(),
                    title: Text("New message from so and so"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
