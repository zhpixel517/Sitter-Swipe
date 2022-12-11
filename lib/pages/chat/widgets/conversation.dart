import 'package:flutter/material.dart';
import 'package:sitter_swipe/app/constants.dart';
import 'package:sitter_swipe/pages/chat/chat.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';

class Conversation extends StatefulWidget {
  String profileImage; // cached image locatior
  String name;
  String? userName; // for retreiving firebase data
  String latestMessage;
  String time;
  bool? latestMessageWasSelf;
  bool read;
  final String? image;
  Conversation(this.profileImage, this.latestMessage, this.time,
      {required this.name,
      required this.read,
      required this.image,
      this.userName,
      this.latestMessageWasSelf,
      Key? key})
      : super(key: key);

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppPadding.conversationChoiceVerticalPadding,
            horizontal: 5),
        child: InkWell(
          borderRadius: const BorderRadius.all(
              Radius.circular(AppSizes.searchBarBorderRadius)),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ChatPage(
                widget.userName,
                false,
                name: widget.name,
                profileImageLocator: widget.image,
              );
            }));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: TanPallete.tan,
                backgroundImage: NetworkImage(widget.image!),
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.globalContentSidePadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: Fonts.mediumStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.latestMessageWasSelf!
                            ? "You: ${widget.latestMessage}"
                            : widget.latestMessage,
                        style: widget.read
                            ? Fonts.smallText
                            : Fonts.bold.copyWith(color: TanPallete.darkGrey),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(widget.time,
                    overflow: TextOverflow.ellipsis,
                    style: widget.read
                        ? Fonts.smallText
                        : Fonts.smallText.copyWith(
                            fontWeight: FontWeight.bold,
                            color: TanPallete.darkGrey)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
