// families or other babysitters interested
// part of baseScreen
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:sitter_swipe/app/constants.dart';
import 'package:sitter_swipe/pages/interested/widgets/interested_person.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/strings.dart';

class InterestedPage extends StatefulWidget {
  const InterestedPage({Key? key}) : super(key: key);

  @override
  InterestedPageState createState() => InterestedPageState();
}

class InterestedPageState extends State<InterestedPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  dynamic indexToAnimateOn;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController!.addListener(() {}); // TODO: wanna change UI on the tabs
  }

  @override
  void dispose() {
    super.dispose();
    tabController!.dispose();
  }

  static List<InterestedPerson> likedYou = [
    InterestedPerson("Zach", "@zach", boy1, "15"),
  ];

  static List<InterestedPerson> youLiked = [];

  static List<InterestedPerson> mutual = [];

  @override
  Widget build(BuildContext context) {
    indexToAnimateOn = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(PageTitles.interested),
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                tabController!.index = index;
              });
            },
            unselectedLabelStyle: Fonts.mediumStyle,
            indicatorColor: TanPallete.tan,
            dividerColor: TanPallete.creamWhite,
            labelColor: TanPallete.darkGrey,
            labelStyle: Fonts.bold,
            controller: tabController,
            tabs: [
              Tab(
                text: "Liked you",
                icon: Badge(
                  label: const Text(""), // # of new notifications
                  isLabelVisible: false, //TODO: check notification
                  child: tabController!.index == 0
                      ? const Icon(
                          EvaIcons.heart,
                          color: TanPallete.tan,
                        )
                      : const Icon(EvaIcons.heartOutline),
                ),
              ),
              Tab(
                text: "You liked",
                icon: tabController!.index == 1
                    ? const Icon(Icons.volunteer_activism,
                        color: TanPallete.tan)
                    : const Icon(Icons.volunteer_activism_outlined),
              ),
              Tab(
                  text: "Mutual",
                  icon: Badge(
                    label: const Text("1"),
                    isLabelVisible: false,
                    child: tabController!.index == 2
                        ? SvgPicture.asset(
                            "assets/icons/heart_check_filled.svg",
                            width: 24.0,
                            height: 24.0,
                            color: TanPallete.tan)
                        : SvgPicture.asset("assets/icons/heart_check.svg",
                            width: 24.0,
                            height: 24.0,
                            color: TanPallete.lightGrey),
                  ))
            ],
          ),
        ),
        body: TabBarView(controller: tabController, children: [
          likedYou.isNotEmpty
              ? Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.globalContentSidePadding),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: likedYou.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 5),
                      itemBuilder: (context, index) {
                        if (indexToAnimateOn != index) {
                          return likedYou[index];
                        } else {
                          return Stack(
                            children: [
                              Lottie.asset('json/heart-animation.json',
                                  animate: true, repeat: true),
                              likedYou[index]
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ])
              : _emptyIndicator(false),
          youLiked.isNotEmpty
              ? Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.globalContentSidePadding),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: youLiked.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 5),
                      itemBuilder: (context, index) {
                        if (indexToAnimateOn != index) {
                          return youLiked[index];
                        } else {
                          return Stack(
                            children: [
                              Lottie.asset('json/heart-animation.json',
                                  animate: true, repeat: true),
                              youLiked[index]
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ])
              : _emptyIndicator(false),
          mutual.isNotEmpty
              ? Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.globalContentSidePadding),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: likedYou.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 5),
                      itemBuilder: (context, index) {
                        if (indexToAnimateOn != index) {
                          return mutual[index];
                        } else {
                          return Stack(
                            children: [
                              Lottie.asset('json/heart-animation.json',
                                  animate: true, repeat: true),
                              mutual[index]
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ])
              : _emptyIndicator(true),
        ]));
  }

  Center _emptyIndicator(bool isOnMutualPage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.globalContentSidePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              EvaIcons.questionMarkCircleOutline,
              color: TanPallete.lightGrey,
              size: AppSizes.mediumIconSize,
            ),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Text(
                isOnMutualPage
                    ? "${AppStrings.noSittersHereYet}\n\n${AppStrings.chatAddedAutomatically}"
                    : AppStrings.noSittersHereYet,
                style: Fonts.smallText,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
