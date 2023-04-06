// get all of their profile images
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sitter_swipe/pages/register/pages.dart';
import 'package:sitter_swipe/pages/register/register_viewmodel.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/services/di.dart';

class ProfileImages extends StatefulWidget {
  const ProfileImages({super.key});

  @override
  State<ProfileImages> createState() => _ProfileImagesState();
}

class _ProfileImagesState extends State<ProfileImages> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> selectedImages = [];

  // 6 empty image references.
  // I did this so that I could place an images on a particular index
  // in order to properly order the images later???

  @override
  Widget build(BuildContext context) {
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
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(6, (index) {
                return InkWell(
                  onTap: () async {
                    // select image and return it to the viewmodel
                    final XFile? image = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    print(image);
                    selectedImages.add(image!);
                    _viewModel.setProfileDisplayImages(selectedImages);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: TanPallete.creamWhite,
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppSizes.swipeCardBorderRadius))),
                    child: Column(
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
                "Please follow our Community Guidelines and present yourself appropriately.",
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
