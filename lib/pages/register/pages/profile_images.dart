// get all of their profile images
import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/register/pages.dart';

class ProfileImages extends StatefulWidget {
  const ProfileImages({super.key});

  @override
  State<ProfileImages> createState() => _ProfileImagesState();
}

class _ProfileImagesState extends State<ProfileImages> {
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
      body: const Center(
        child: Text("Profile Image"),
      ),
    );
  }
}
