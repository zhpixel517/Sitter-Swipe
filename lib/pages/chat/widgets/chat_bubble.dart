import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/chat/widgets/other_chat_indicators.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';

class ChatBubble extends StatefulWidget {
  final String? text;
  final bool? isSelf;
  const ChatBubble({this.text, this.isSelf, Key? key}) : super(key: key);

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
                  color: widget.isSelf! ? TanPallete.tan : TanPallete.lightGrey,
                  borderRadius: BorderRadius.only(
                      topLeft: !widget.isSelf!
                          ? const Radius.circular(0)
                          : const Radius.circular(
                              AppSizes.searchBarBorderRadius),
                      bottomLeft:
                          const Radius.circular(AppSizes.searchBarBorderRadius),
                      bottomRight:
                          const Radius.circular(AppSizes.searchBarBorderRadius),
                      topRight: widget.isSelf!
                          ? const Radius.circular(0)
                          : const Radius.circular(
                              AppSizes.searchBarBorderRadius))),
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                child: Text(
                  widget.text!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
            ChatIndicators.timeIndicator("3:15", widget.isSelf!)
          ],
        ),
      ),
    );
  }
}
