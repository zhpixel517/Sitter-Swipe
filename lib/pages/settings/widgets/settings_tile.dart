// a settings tile
import 'package:flutter/material.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';

class SettingsTile extends StatefulWidget {
  final String? title;
  final IconData? icon;
  final bool? toggle;
  const SettingsTile({this.title, this.icon, required this.toggle, Key? key})
      : super(key: key);

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  bool toggled = false; // get preferences
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        borderRadius: const BorderRadius.all(
            Radius.circular(AppSizes.searchBarBorderRadius)),
        child: widget.toggle == false
            ? ListTile(
                style: ListTileStyle.list,
                title: Text(
                  widget.title!,
                  style: Fonts.mediumStyle,
                ),
                leading: Icon(
                  widget.icon!,
                  color: TanPallete.tan,
                ),
              )
            : SwitchListTile(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(AppSizes.searchBarBorderRadius))),
                title: Text(
                  widget.title!,
                  style: Fonts.mediumStyle,
                ),
                value: toggled,
                onChanged: (bool value) {
                  setState(() {
                    toggled = value;
                  });
                }));
  }
}

class SettingsSection extends StatelessWidget {
  final String? title;
  final List<Widget> settingsTiles;
  const SettingsSection(this.title, this.settingsTiles, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: Fonts.secondaryFont.copyWith(
              color: TanPallete.richBlack, fontWeight: FontWeight.bold),
        ),
        SizedBox(child: Column(children: settingsTiles))
      ],
    );
  }
}
