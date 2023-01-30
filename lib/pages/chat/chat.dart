import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/app/constants.dart';
import 'package:sitter_swipe/pages/chat/widgets/chat_bubble.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/strings.dart';

// the actual messaging screen
class ChatPage extends StatefulWidget {
  String? name;
  String? userName; // for firebase?
  bool
      cameFromProfile; // "View Profile" butotn won't show if they already came from the profile screen
  final String? profileImageLocator;
  ChatPage(this.userName, this.cameFromProfile,
      {required this.name, required this.profileImageLocator, Key? key})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController chatTextController = TextEditingController();
  ScrollController scrollController = ScrollController();

  List chats = [
    const ChatBubble(
      text: "Hey! Need a sitter?",
      isSelf: true,
    ),
    const ChatBubble(
      text: "Yeah, that would be great. What does you schedule look like? ",
      isSelf: false,
    ),
    const ChatBubble(
      text: "Pretty free this next weekend.",
      isSelf: true,
    ),
    const ChatBubble(
      text: "How's yours looking?",
      isSelf: true,
    )
  ];

  List<String> popUpMenuItems = ["View Profile", "Call", "Block", "Report"];
  List<String> popUpFromProfile = ["Call", "Block", "Report"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.profileImageLocator!),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            Text(widget.name!),
          ],
        ),
        leading: IconButton(
          icon: const Icon(EvaIcons.arrowBack),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton(
              icon: const Icon(
                EvaIcons.moreVertical,
              ),
              itemBuilder: ((context) {
                return (widget.cameFromProfile
                        ? popUpFromProfile
                        : popUpMenuItems)
                    .map((String item) => PopupMenuItem(
                          textStyle: Fonts.mediumStyle,
                          value: item,
                          child: Text(item),
                        ))
                    .toList();
              }))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: chats.isNotEmpty
                ? ListView.builder(
                    controller: scrollController,
                    itemCount: chats.length,
                    itemBuilder: (builder, index) {
                      return chats[index];
                    })
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      " ${AppStrings.youStartedAConversation} ${widget.name}",
                      style:
                          Fonts.smallText.copyWith(color: TanPallete.lightGrey),
                    ),
                  ),
          ),
          const Divider(
            color: TanPallete.darkGrey,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.globalContentSidePadding),
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: AppPadding.p18),
                      child: TextField(
                          controller: chatTextController,
                          decoration: InputDecoration(
                              hintText: "Aa",
                              prefixIcon: IconButton(
                                  icon: const Icon(EvaIcons.attach),
                                  onPressed: () {}))),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: IconButton(
                          color: TanPallete.tan,
                          icon: const Icon(
                            EvaIcons.paperPlane,
                            size: AppSizes.mediumIconSize,
                          ),
                          onPressed: () {
                            setState(() {
                              if (scrollController.hasClients) {
                                final bottomPosition =
                                    scrollController.position.maxScrollExtent;
                                scrollController.jumpTo(bottomPosition);
                              }
                              if (chatTextController.text.isNotEmpty) {
                                setState(() {
                                  chats.add(ChatBubble(
                                      text: chatTextController.text,
                                      isSelf: true));
                                  chatTextController.text = "";
                                });
                              }
                            });
                          }))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
