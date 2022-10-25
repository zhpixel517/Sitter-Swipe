import 'package:flutter/material.dart';
import 'package:sitter_swipe/app/constants.dart';
import 'package:sitter_swipe/pages/profile/profile.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';

class InterestedPerson extends StatefulWidget {
  String name; // display name
  String userName; // send into firebase
  InterestedPerson(this.name, this.userName, {Key? key}) : super(key: key);

  @override
  _InterestedPersonState createState() => _InterestedPersonState();
}

class _InterestedPersonState extends State<InterestedPerson> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UserProfile(widget.userName, widget.name, false);
          }));
        },
        child: LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(AppSizes.searchBarBorderRadius),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        edp445Image,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: Fonts.bold.copyWith(color: Colors.white),
                        ),
                        Text(
                          widget.userName,
                          style: Fonts.secondaryFont,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}