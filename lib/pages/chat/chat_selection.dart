// messaging
// part of baseScreen

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/chat/chat_viewmodel.dart';
import 'package:sitter_swipe/pages/chat/widgets/conversation.dart';
import 'package:sitter_swipe/pages/login/login.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/strings.dart';
import 'package:sitter_swipe/resources/theme.dart';

class ChatSelection extends StatefulWidget {
  const ChatSelection({Key? key}) : super(key: key);

  @override
  _ChatSelectionState createState() => _ChatSelectionState();
}

class _ChatSelectionState extends State<ChatSelection> {
  final ChatViewModel _viewModel = instance<ChatViewModel>();
  final FocusNode messageSearchFocusNode = FocusNode();
  List<Conversation> conversations = [
    Conversation(
      "",
      "My little brother loves legoes too!",
      "1 hr",
      name: "Janice",
      userName: "jj89",
      read: false,
      latestMessageWasSelf: false,
    ),
    Conversation(
      "",
      "Need a sitter?",
      "5 min",
      name: "Joseph",
      userName: "zach-attack",
      read: true,
      latestMessageWasSelf: true,
    ),
    Conversation(
      "",
      "Need a sitter?",
      "5 min",
      name: "Zachary",
      userName: "zach-attack",
      read: true,
      latestMessageWasSelf: false,
    ),
    Conversation(
      "",
      "Need a sitter?",
      "5 min",
      name: "Zachary",
      userName: "zach-attack",
      read: true,
      latestMessageWasSelf: false,
    ),
    Conversation(
      "",
      "Need a sitter?",
      "5 min",
      name: "Zachary",
      userName: "zach-attack",
      read: true,
      latestMessageWasSelf: false,
    ),
    Conversation(
      "",
      "Need a sitter?",
      "5 min",
      name: "Zachary",
      userName: "zach-attack",
      read: true,
      latestMessageWasSelf: false,
    ),
  ];

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(PageTitles.chat),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.globalContentSidePadding),
        child: Column(
          children: [
            TextField(
                focusNode: messageSearchFocusNode,
                decoration: searchBarDecoration(
                    messageSearchFocusNode, AppStrings.messageSearch)),
            conversations.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                        itemCount: conversations.length,
                        itemBuilder: (context, index) {
                          final item = conversations[index].name;
                          return Dismissible(
                            background:
                                _buildDismissibleColorBackground(Colors.red),
                            secondaryBackground:
                                _buildDismissibleColorBackground(Colors.blue),
                            key: Key(item),
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                setState(() {
                                  conversations.removeAt(index);
                                });
                              } else {
                                setState(() {
                                  conversations[index].read = true;
                                });
                              }
                              return null;
                            },
                            child: conversations[index],
                          );
                        }),
                  )
                : Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "No messages. Why don't you start one?",
                            style: Fonts.smallText,
                          )
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

Widget _buildDismissibleColorBackground(Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(
        vertical: AppPadding.conversationChoiceVerticalPadding),
    child: Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
              Radius.circular(AppSizes.searchBarBorderRadius))),
      child: Align(
          alignment: color == Colors.red
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p18),
            child: Icon(
              color == Colors.red ? EvaIcons.trash : EvaIcons.checkmarkCircle,
              color: Colors.white,
            ),
          )),
    ),
  );
}
