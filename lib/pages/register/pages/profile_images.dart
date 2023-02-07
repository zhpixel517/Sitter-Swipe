// get all of their profile images
import 'package:flutter/material.dart';

class ProfileImages extends StatefulWidget {
  const ProfileImages({super.key});

  @override
  State<ProfileImages> createState() => _ProfileImagesState();
}

class _ProfileImagesState extends State<ProfileImages> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Profile Image"),
    );
  }
}
