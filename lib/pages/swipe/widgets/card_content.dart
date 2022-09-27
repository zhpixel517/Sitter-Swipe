import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';

class CardContent extends StatelessWidget {
  final String? image; // for now, the url to image. later, a firebase uri
  final String? userName;
  final String? fullName;
  final String? age;
  final String? occupation;
  final String? distance;
  const CardContent(
      {required this.image,
      required this.userName,
      required this.fullName,
      required this.age,
      required this.occupation,
      required this.distance,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: TanPallete.creamWhite,
          borderRadius: BorderRadius.all(
              Radius.circular(AppSizes.swipeCardBorderRadius))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppSizes.swipeCardBorderRadius),
                  ),
                  child: Image(
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                          child: Icon(EvaIcons.questionMarkCircle));
                    },
                    fit: BoxFit.fill,
                    image: NetworkImage(image!),
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
          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    fullName!,
                    style: Fonts.bold.copyWith(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "${occupation!}, $age",
                    style: Fonts.smallText,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // hero animation?
                },
                child: const Text("View Profile"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
