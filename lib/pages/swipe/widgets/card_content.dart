import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/profile/profile.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:swipe_cards/swipe_cards.dart';

class CardContent extends StatelessWidget {
  final String? image; // for now, the url to image. later, a firebase uri
  final String? userName;
  final String? fullName;
  final String? age;
  final String? distance;
  final String? hourlyRate;
  final double? rating;
  final bool? isFamily;
  final AlignmentGeometry? alignment;
  // final MatchEngine? matchEngineInstance;
  const CardContent(
      {required this.image,
      required this.userName,
      required this.fullName,
      required this.age,
      required this.rating,
      required this.distance,
      required this.hourlyRate,
      required this.isFamily,
      required this.alignment,
      // required this.matchEngineInstance,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserProfile(
                        userName,
                        fullName,
                        false,
                        isFamily!,
                        age!,
                        // matchEngineInstance: ,
                        profileImage: image,
                      )));
        },
        child: Container(
          decoration: const BoxDecoration(
              color: TanPallete.creamWhite,
              borderRadius: BorderRadius.all(
                  Radius.circular(AppSizes.swipeCardBorderRadius))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppSizes.swipeCardBorderRadius),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image(
                            alignment: alignment!,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                  child: Icon(EvaIcons.questionMarkCircle));
                            },
                            fit: BoxFit.fitHeight,
                            image: NetworkImage(image!),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.7)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.6, 0.95])),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${fullName!}, ${age!}",
                                        style: Fonts.bold.copyWith(
                                            color: Colors.white,
                                            fontSize: 25,
                                            letterSpacing: 0.5),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            rating.toString(),
                                            style: Fonts.smallText
                                                .copyWith(color: Colors.white),
                                          ),
                                          const Icon(
                                            Icons.star,
                                            size: 17.0,
                                            color: Colors.yellow,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Chip(
                          label: Text("$distance miles away"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
