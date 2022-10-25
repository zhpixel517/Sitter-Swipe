// someone else's profile that you tap on
// come here from the swipe screen
// use a hero animation?

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/app/constants.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/routes.dart';
import 'package:sitter_swipe/resources/strings.dart';

class UserProfile extends StatefulWidget {
  // what kinds of data points do I need to pass through?
  // retreive hobbies and other relevent profile data when coming from the swipe screen
  String? userName; // send to firebase
  // cache the profile image first.
  String? name;
  bool isSelf;
  UserProfile(this.userName, this.name, this.isSelf, {Key? key})
      : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List<String> listPopUpOptions = ["Send a message", "Call", "Block", "Report"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Stack(
              fit: StackFit.expand,
              children: [
                const Hero(
                  tag: 'profileImage',
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft:
                            Radius.circular(AppSizes.searchBarBorderRadius),
                        bottomRight:
                            Radius.circular(AppSizes.searchBarBorderRadius)),
                    child: Image(
                      // put a carousel here with multiple images
                      fit: BoxFit.fill,
                      image: NetworkImage(edp445Image),
                    ),
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.globalContentSidePadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: widget.isSelf
                            ? [
                                _customTopIconButton(EvaIcons.settings, () {
                                  Navigator.pushNamed(context, Routes.settings);
                                })
                              ]
                            : [
                                _customTopIconButton(EvaIcons.arrowBack, () {
                                  Navigator.pop(context);
                                }),
                                CircleAvatar(
                                  backgroundColor: TanPallete.tan,
                                  child: PopupMenuButton(
                                      icon: const Icon(
                                        EvaIcons.moreVertical,
                                        color: Colors.white,
                                      ),
                                      itemBuilder: ((context) {
                                        return listPopUpOptions
                                            .map((String item) => PopupMenuItem(
                                                  textStyle: Fonts.mediumStyle,
                                                  value: item,
                                                  child: Text(item),
                                                ))
                                            .toList();
                                      })),
                                )
                              ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.globalContentSidePadding,
                      vertical: AppPadding.p10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name!,
                        style: Fonts.bold
                            .copyWith(color: Colors.white, fontSize: 25),
                      ),
                      Text(widget.userName!,
                          style: Fonts.smallText.copyWith(fontSize: 15))
                    ],
                  ),
                )
              ],
            ),
          ),
          widget.isSelf
              ? const SizedBox(height: 0, width: 0)
              : Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppPadding.globalContentSidePadding,
                      AppPadding.globalContentSidePadding,
                      AppPadding.globalContentSidePadding,
                      0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildProfileActionButton(
                          EvaIcons.close, ButtonLabels.pass, () {}),
                      _buildProfileActionButton(
                          EvaIcons.heart, ButtonLabels.like, () {}),
                      _buildProfileActionButton(
                          EvaIcons.messageCircle, ButtonLabels.message, () {}),
                    ],
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.globalContentSidePadding),
            child: Container(
              decoration: const BoxDecoration(
                  color: TanPallete.creamWhite,
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.searchBarBorderRadius))),
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                child: Text(
                  "a;skldjfa;lskdjf;laskdjf;laksjdflkjahsdflkjahsdflkjashdflkjhasdflkjhasdlfkjhsadlfkjhasdlkfjhasldkfjhasdlkfjhasldkfjhasldkfjhasdlkfjhaldskjfhaldskjfhalsdkjfhasldkjfhalksdjfhalksdjfhalksdjfhlaksjdfhlaksjdfhlaksjdfhlkashfo;wqehr[oihasdfglkjahsbda",
                  style:
                      Fonts.mediumStyle.copyWith(color: TanPallete.richBlack),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _customTopIconButton(IconData icon, Function callback) {
    return CircleAvatar(
      backgroundColor: TanPallete.tan,
      child: IconButton(
          onPressed: () {
            callback();
          },
          icon: Icon(
            icon,
            color: Colors.white,
          )),
    );
  }

  Widget _buildProfileActionButton(
      IconData icon, String text, Function callback) {
    return Expanded(
      child: Column(
        children: [
          IconButton(
            onPressed: () => callback,
            icon: Icon(
              icon,
              color: TanPallete.tan,
              size: 35.0,
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: Fonts.smallText,
          )
        ],
      ),
    );
  }
}
