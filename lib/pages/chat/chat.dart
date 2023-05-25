import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
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
  bool? isAi;
  final String? profileImageLocator;
  ChatPage(this.userName, this.cameFromProfile,
      {required this.name,
      required this.profileImageLocator,
      required this.isAi,
      key})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController chatTextController = TextEditingController();
  ScrollController scrollController = ScrollController();

  List aiChat = [
    const ChatBubble(
      text:
          "Hi! I'm the Babysitter Assistant for Busy Youths, or B.A.B.Y for short. I can help you with any sort of babysitting ideas that you need. Ask away!",
      // "Hi! I'm your personalized AI helper. I can help you with finding recipies, coming up with ideas for games for kids, and with housekeeping tips! Ask me anything!",
      isSelf: false,
      isTyping: false,
    ),
    /*
    const ChatBubble(
      text: "any ideas of games I could play with 2 rowdy kids?",
      isSelf: true,
      isTyping: false,
    ),
    */
  ];

  List chats = [
    const ChatBubble(
      text: "Hey! Need a sitter?",
      isSelf: true,
      isTyping: false,
    ),
    const ChatBubble(
      text: "Yeah, that would be great. What does you schedule look like? ",
      isSelf: false,
      isTyping: false,
    ),
    const ChatBubble(
      text: "Pretty free this next weekend.",
      isSelf: true,
      isTyping: false,
    ),
    const ChatBubble(
      text: "How's yours looking?",
      isSelf: true,
      isTyping: false,
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
              backgroundImage: AssetImage(widget.profileImageLocator!),
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
            child: aiChat.isNotEmpty
                ? ListView.builder(
                    controller: scrollController,
                    itemCount: aiChat.length,
                    itemBuilder: (builder, index) {
                      return aiChat[index];
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
                          minLines: 1,
                          maxLines: 3,
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
                                // temp for the presentation
                                setState(() {
                                  if (widget.isAi!) {
                                    aiChat.add(ChatBubble(
                                      text: chatTextController.text,
                                      isSelf: true,
                                      isTyping: false,
                                    ));
                                    aiChat.add(const ChatBubble(
                                      text: "",
                                      isSelf: false,
                                      isTyping: true,
                                    ));
                                  }
                                  /*
                                  widget.isAi!
                                      ? aiChat.add(const ChatBubble(
                                          text: "",
                                          isSelf: false,
                                          isTyping: true,
                                        ))
                                      : chats.add(ChatBubble(
                                          text: chatTextController.text,
                                          isSelf: true,
                                          isTyping: false,
                                        ));
                                        */
                                  //! Just for show
                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    setState(() {
                                      aiChat.removeLast();
                                      aiChat.add(
                                        const ChatBubble(
                                          text:
                                              "Sure! Here are some game ideas for rowdy kids: \n\nObstacle Course: Create an obstacle course in the backyard or living room with objects to climb over, under, and through. Time the kids to see who can complete the course the fastest, and add in challenges like carrying a ball or balloon between their legs. \n\nFreeze Dance: Play music and have the kids dance around, but when the music stops, they have to freeze in place. You can mix up the dance styles (e.g. ballet, hip-hop, silly) and make it more challenging by calling out poses they have to freeze in, like \"air guitar\" or \"statue of liberty.\" \n\nRemember, safety should always come first, so make sure to supervise the kids and adjust the games to fit their age, skill level, and space. Have fun!",
                                          isSelf: false,
                                          isTyping: false,
                                        ),
                                      );
                                    });
                                  });
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
