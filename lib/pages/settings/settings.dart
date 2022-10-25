// app settings screen
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sitter_swipe/app/constants.dart';
import 'package:sitter_swipe/pages/settings/widgets/settings_tile.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';
import 'package:sitter_swipe/resources/strings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(EvaIcons.arrowBack),
          onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: true,
        title: const Text(PageTitles.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.globalContentSidePadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: const Center(
                    child: CircleAvatar(
                  radius: 100.0,
                  backgroundColor: TanPallete.tan,
                  backgroundImage: NetworkImage(edp445Image),
                )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Joe",
                        style: Fonts.bold.copyWith(fontSize: 30.0),
                      ),
                      Text(
                        "@joe_mom",
                        style: Fonts.smallText,
                      )
                    ],
                  ),
                ),
              ),
              const SettingsSection("General", [
                SettingsTile(
                  title: "Profile Settings",
                  icon: EvaIcons.person,
                  toggle: false,
                ),
                SettingsTile(
                  title: "Use miles",
                  icon: EvaIcons.swap,
                  toggle: true,
                )
              ]),
              const SettingsSection("Advanced", [
                SettingsTile(
                  title: "Reset Location Data",
                  icon: EvaIcons.pin,
                  toggle: false,
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
