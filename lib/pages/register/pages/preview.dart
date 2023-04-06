// preview the completed profile
import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/profile/profile.dart';
import 'package:sitter_swipe/pages/register/pages.dart';
import 'package:sitter_swipe/pages/register/register_viewmodel.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/services/di.dart';

class Preview extends StatefulWidget {
  const Preview({super.key});

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();

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
      body: UserProfile(
        '',
        _viewModel.userFullName,
        true,
        !_viewModel.userIsSitter!,
        _viewModel.userAge.toString(),
        profileImage: _viewModel.userProfileImages![0].path,
        didComeFromRegisteredScreen: true,
        bio: _viewModel.userBio!,
      ),
    );
  }
}
