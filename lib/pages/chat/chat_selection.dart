// messaging
// part of baseScreen

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/chat/chat_viewmodel.dart';
import 'package:sitter_swipe/pages/chat/widgets/conversation.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/image_assets.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/strings.dart';
import 'package:sitter_swipe/resources/theme.dart';
import 'package:sitter_swipe/services/di.dart';

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
        "assets/images/IconKitchen-Output/ios/AppIcon-40@2x.png", "", "Now",
        name: "B.A.B.Y",
        read: false,
        image: "assets/images/IconKitchen-Output/android/play_store_512.png",
        latestMessageWasSelf: false,
        isAiConversation: true),
    Conversation(
      "",
      "What time would best for you?",
      "10:39",
      name: "Paula",
      read: true,
      image: ImageAssets.chilton,
      latestMessageWasSelf: false,
      isAiConversation: false,
    ),
    Conversation(
      "",
      "Hello! I found your profile and",
      "9:45",
      name: "Jeremy",
      read: true,
      image: ImageAssets.qualls,
      latestMessageWasSelf: true,
      isAiConversation: false,
    ),
    Conversation(
      "",
      "I'll let you know, thanks!",
      "8:51",
      name: "Kris",
      read: true,
      image: ImageAssets.schneider,
      latestMessageWasSelf: false,
      isAiConversation: false,
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
                decoration: globalInputDecoration(messageSearchFocusNode,
                    AppStrings.messageSearch, EvaIcons.search)),
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
                            "No messages. Why don't you start swiping to get started?",
                            textAlign: TextAlign.center,
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
