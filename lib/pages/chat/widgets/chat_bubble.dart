import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/chat/widgets/other_chat_indicators.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';

class ChatBubble extends StatefulWidget {
  final String? text;
  final bool? isSelf;
  final bool? isTyping; //TODO: take a look at this mechanism
  const ChatBubble({this.text, this.isSelf, required this.isTyping, Key? key})
      : super(key: key);

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          widget.isSelf!
              ? AppPadding.chatBubbleHorizontalBuffer
              : AppPadding.p18,
          6,
          widget.isSelf!
              ? AppPadding.p18
              : AppPadding.chatBubbleHorizontalBuffer,
          4),
      child: Align(
        alignment:
            widget.isSelf! ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: widget.isSelf!
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                  color:
                      widget.isSelf! ? TanPallete.tan : TanPallete.creamWhite,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(AppSizes.searchBarBorderRadius))),
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                child: !widget.isTyping!
                    ? Text(widget.text!,
                        style: widget.isSelf!
                            ? Fonts.selfChatTextStyle
                            : Fonts.otherChatTextStyle)
                    : ChatIndicators.typingIndicator(),
              ),
            ),
            ChatIndicators.timeIndicator(
                "${DateTime.now().hour}:0${DateTime.now().minute}", //! static 0
                widget.isSelf!)
          ],
        ),
      ),
    );
  }
}
