// preview the completed profile
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sitter_swipe/app/constants.dart';
import 'package:sitter_swipe/models/person/child.dart';
import 'package:sitter_swipe/pages/register/pages.dart';
import 'package:sitter_swipe/pages/register/register_viewmodel.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/services/di.dart';
import 'package:sitter_swipe/services/responsive.dart';

class Preview extends StatefulWidget {
  const Preview({super.key});

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  int? carouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          RegisterPageTitles.preview,
          style: Fonts.bold,
        ),
      ),
      body: CupertinoScrollbar(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft:
                                Radius.circular(AppSizes.searchBarBorderRadius),
                            bottomRight: Radius.circular(
                                AppSizes.searchBarBorderRadius)),
                        child: Stack(
                          children: [
                            CarouselSlider(
                                items: List.generate(
                                    _viewModel.userProfileImages!.length,
                                    (index) {
                                  return Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image(
                                        image: FileImage(File(_viewModel
                                            .userProfileImages![index].path)),
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                      imageBlur(constraints),
                                    ],
                                  );
                                }),
                                options: CarouselOptions(
                                    height: double.infinity,
                                    viewportFraction: 1,
                                    enableInfiniteScroll: false,
                                    onPageChanged: ((index, reason) {
                                      setState(() {
                                        carouselIndex = index;
                                      });
                                    }))),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: AppPadding.p10),
                                child: DotsIndicator(
                                  position: carouselIndex!.toDouble(),
                                  dotsCount:
                                      _viewModel.userProfileImages!.length,
                                  decorator: const DotsDecorator(
                                      activeColor: Colors.white,
                                      color: TanPallete.darkGrey),
                                ),
                              ),
                            )
                          ],
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
                                _viewModel.userFullName!,
                                style: Fonts.bold.copyWith(
                                    color: Colors.white, fontSize: 25),
                              ),
                              Text(_viewModel.userNickName ?? "",
                                  style: Fonts.smallText.copyWith(fontSize: 15))
                            ],
                          )),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(
                        AppPadding.globalContentSidePadding),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: TanPallete.creamWhite,
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppSizes.searchBarBorderRadius)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p10),
                        child: Column(
                          children: [
                            !_viewModel.userIsSitter!
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              _viewModel.children!.length
                                                  .toString(),
                                              style: Fonts.bold.copyWith(
                                                  fontSize: FontSizes
                                                      .profileAttributesSize)),
                                          Text("Children",
                                              style: Fonts.smallText),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "\$${double.parse(_viewModel.sitterChargeRate!).round()}",
                                              style: Fonts.bold.copyWith(
                                                  fontSize: FontSizes
                                                      .profileAttributesSize)),
                                          Text("Will pay rate",
                                              style: Fonts.smallText),
                                        ],
                                      )
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Text(_viewModel.userAge!.toString(),
                                              style: Fonts.bold.copyWith(
                                                  fontSize: FontSizes
                                                      .profileAttributesSize)),
                                          Text("Age", style: Fonts.smallText)
                                        ],
                                      ),
                                    ],
                                  ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppPadding.p8),
                              child: Text(_viewModel.userBio!,
                                  style: Fonts.mediumStyle.copyWith(
                                    color: TanPallete.richBlack,
                                  )),
                            ),
                            _viewModel.userIsSitter!
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: AppPadding.p8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Availability: ",
                                            style: Fonts.smallText),
                                        Text(
                                          _viewModel.sitterAvailability!,
                                          style:
                                              Fonts.bold.copyWith(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),
                    )),
                !_viewModel.userIsSitter!
                    ? Padding(
                        padding: const EdgeInsets.all(
                            AppPadding.globalContentSidePadding),
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: TanPallete.creamWhite,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  AppSizes.searchBarBorderRadius))),
                          child: Padding(
                            padding: const EdgeInsets.all(AppPadding.p10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Children",
                                    style: Fonts.mediumStyle,
                                  ),
                                  for (Child child in _viewModel.children!)
                                    Padding(
                                      padding:
                                          const EdgeInsets.all(AppPadding.p8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: AppPadding.p5),
                                            child: Text(
                                                "${child.name!}, age ${child.age!}",
                                                style: Fonts.bold
                                                    .copyWith(fontSize: 20)),
                                          ),
                                          Text(
                                            "Hobbies:",
                                            style: Fonts.smallText,
                                          ),
                                          Text(child.hobbies!,
                                              style: Fonts.mediumStyle)
                                        ],
                                      ),
                                    ),
                                ]),
                          ),
                        ))
                    : const SizedBox(),
                Padding(
                    padding: const EdgeInsets.all(
                        AppPadding.globalContentSidePadding),
                    child: Column(
                      children: [
                        Center(
                            child: Text(
                          "4.7",
                          style: Fonts.bold.copyWith(
                              fontSize: SizeConfig.safeBlockHorizontal! * 8),
                        )),
                        RatingBarIndicator(
                          unratedColor: TanPallete.creamWhite,
                          rating: 4.7,
                          itemBuilder: (context, index) => const Icon(
                            EvaIcons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 30.0, // get rating from firebase
                        ),
                        Center(
                          child: Text("5 Reviews",
                              style: Fonts.smallText.copyWith(
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal! * 3.5)),
                        ),
                      ],
                    )),
              ],
            ),
          );
        }),
      ),
    );
  }
}

/*
UserProfile(
        '',
        _viewModel.userFullName,
        true,
        !_viewModel.userIsSitter!,
        _viewModel.userAge.toString(),
        profileImages: List.generate(
            _viewModel.userProfileImages!.length,
            (index) => _viewModel.userProfileImages![index]
                .path), //  _viewModel.userProfileImages!,
        didComeFromRegisteredScreen: true,
        bio: _viewModel.userBio!,
      ),*/
