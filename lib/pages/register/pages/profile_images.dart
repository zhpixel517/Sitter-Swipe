// get all of their profile images
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sitter_swipe/pages/register/pages.dart';
import 'package:sitter_swipe/pages/register/provider/button_state_provider.dart';
import 'package:sitter_swipe/pages/register/register_viewmodel.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/strings.dart';
import 'package:sitter_swipe/services/di.dart';

class ProfileImages extends StatefulWidget {
  const ProfileImages({super.key});

  @override
  State<ProfileImages> createState() => _ProfileImagesState();
}

class _ProfileImagesState extends State<ProfileImages> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker imagePicker = ImagePicker();
  List selectedImages = List.filled(6, null);

  // 6 empty image references.
  // I did this so that I could place an images on a particular index
  // in order to properly order the images later

  _repopulateGrid() {
    if (!const ListEquality()
        .equals(_viewModel.userProfileImages, List.filled(6, null))) {
      // if our profile already has some images, repopulate them.
      // this is tricky because I have to match the format of List.filled
      int numberOfNullVals = 6 - _viewModel.userProfileImages!.length;
      final List emptyList = List.filled(numberOfNullVals, null);
      final List savedImages = _viewModel.userProfileImages!;
      selectedImages = [];
      selectedImages
        ..addAll(savedImages)
        ..addAll(emptyList);

      // will recreate list of len 6 to match the format
    }
  }

  @override
  void initState() {
    super.initState();
    _repopulateGrid();
  }

  _checkBlur(BlurProvider provider) {
    if (const ListEquality().equals(selectedImages, List.filled(6, null))) {
      // if our selected images are empty
      provider.blur();
    } else {
      provider.unblur();
    }
  }

  @override
  Widget build(BuildContext context) {
    final blurProvider = Provider.of<BlurProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkBlur(blurProvider);
    });
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            RegisterPageTitles.images,
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .appBarTheme
                .titleTextStyle!
                .copyWith(fontSize: 23),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.globalContentSidePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: AppSizes.gridAxisSpacing,
              crossAxisSpacing: AppSizes.gridAxisSpacing,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(6, (index) {
                return InkWell(
                  onTap: () async {
                    // select image and return it to the viewmodel
                    final image = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    setState(() {
                      selectedImages[index] = File(image!.path);
                    });
                    _viewModel.addProfileDisplayImage(selectedImages[index]);
                    _checkBlur(blurProvider);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: TanPallete.creamWhite,
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppSizes.searchBarBorderRadius))),
                    child: selectedImages[index] != null
                        ? ClipRRect(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(
                                    AppSizes.searchBarBorderRadius)),
                            child: Image.file(
                              File(selectedImages[index].path),
                              fit: BoxFit.cover,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(AppPadding.p5),
                                child: Icon(
                                  EvaIcons.cameraOutline,
                                  color: TanPallete.lightGrey,
                                ),
                              ),
                              Text('Tap to add photo', style: Fonts.smallText),
                            ],
                          ),
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p10),
              child: Text(
                _viewModel.userIsSitter!
                    ? AppStrings.followGuidelinesSitter
                    : AppStrings.followGuidelinesParent,
                textAlign: TextAlign.center,
                style: Fonts.smallText,
              ),
            )
          ],
        ),
      ),
    );
  }
}
