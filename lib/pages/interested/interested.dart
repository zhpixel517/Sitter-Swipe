// families or other babysitters interested
// part of baseScreen
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
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
    tabController = TabController(length: 2, vsync: this);
    tabController!.addListener(() {}); // TODO: wanna change UI on the tabs
  }

  @override
  void dispose() {
    super.dispose();
    tabController!.dispose();
  }

  static List<InterestedPerson> likedYou = [];

  static List<InterestedPerson> youLiked = [];

  @override
  Widget build(BuildContext context) {
    indexToAnimateOn = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(PageTitles.interested),
          bottom: TabBar(
            indicatorColor: TanPallete.tan,
            dividerColor: TanPallete.creamWhite,
            labelColor: TanPallete.darkGrey,
            labelStyle: Fonts.mediumStyle,
            controller: tabController,
            tabs: [
              Tab(
                text: "Liked you",
                icon: tabController!.index == 0
                    ? const Icon(
                        EvaIcons.heart,
                        color: TanPallete.tan,
                      )
                    : const Icon(EvaIcons.heartOutline),
              ),
              Tab(
                text: "You liked",
                icon: tabController!.index == 1
                    ? const Icon(Icons.volunteer_activism,
                        color: TanPallete.tan)
                    : const Icon(Icons.volunteer_activism_outlined),
              )
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
              : _emptyIndicator(),
          youLiked.isNotEmpty
              ? Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.globalContentSidePadding),
                    child: GridView.builder(
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
              : _emptyIndicator()
        ]));
  }

  Center _emptyIndicator() {
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
                AppStrings.nothingHere,
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
