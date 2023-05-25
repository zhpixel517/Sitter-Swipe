import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';

class Review extends StatefulWidget {
  final String? fromName;
  //final String profileImageLocator;
  final double? stars;
  final String? review;
  final String? date;
  final String? profileImage;
  const Review(
      {super.key,
      required this.fromName,
      required this.stars,
      required this.review,
      required this.profileImage,
      required this.date});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.globalContentSidePadding,
          vertical: AppPadding.p8),
      child: Container(
        decoration: const BoxDecoration(
            color: TanPallete.creamWhite,
            borderRadius: BorderRadius.all(
                Radius.circular(AppSizes.searchBarBorderRadius))),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.globalContentSidePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: AppPadding.globalContentSidePadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(widget.profileImage!),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.fromName!, style: Fonts.bold),
                            Row(
                              children: [
                                const Icon(EvaIcons.starOutline),
                                Text(
                                  widget.stars!.toString(),
                                  style: Fonts.mediumStyle,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(widget.date!, style: Fonts.smallText)
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.all(AppPadding.globalContentSidePadding),
                child: Text(
                  widget.review!,
                  style:
                      Fonts.mediumStyle.copyWith(color: TanPallete.richBlack),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
