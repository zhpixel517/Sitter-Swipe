// Skill and certifications chips that display on someone's profile

import 'package:flutter/material.dart';
import 'package:sitter_swipe/models/certifications.dart';
import 'package:sitter_swipe/models/skills.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/fonts.dart';
import 'package:sitter_swipe/resources/nums.dart';

class SkillChip extends StatefulWidget {
  final Skill? skill;
  final bool? displayedOnDiscoverySheet;
  const SkillChip({
    super.key,
    required this.skill,
    required this.displayedOnDiscoverySheet,
  });

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  bool? _isEnabled;

  @override
  void initState() {
    super.initState();
    _isEnabled = widget.displayedOnDiscoverySheet! ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    final Color color = colorFromSkill(widget.skill!);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: TooltipTheme(
        data: TooltipThemeData(
            margin: const EdgeInsets.symmetric(
                horizontal: AppPadding.globalContentSidePadding),
            textStyle: Fonts.smallText.copyWith(color: Colors.white)),
        child: InputChip(
          onPressed: () {
            if (widget.displayedOnDiscoverySheet!) {
              setState(() {
                _isEnabled = !_isEnabled!;
              });
            }
          },
          isEnabled: true,
          elevation: 0,
          tooltip: skillDescriptionFromSkill(widget.skill!, true),
          backgroundColor: _isEnabled! ? color : TanPallete.lightGrey,
          avatar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Icon(iconFromSkillType(widget.skill!),
                color: _isEnabled!
                    ? textColorFromColor(color)
                    : textColorFromColor(color).withOpacity(0.4)),
          ),
          label: Text(skillTitleFromSkill(widget.skill!)),
          labelStyle: Fonts.smallText.copyWith(
              color: _isEnabled!
                  ? textColorFromColor(color)
                  : textColorFromColor(color).withOpacity(0.4),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CertificationChip extends StatelessWidget {
  final Certification? cert;
  const CertificationChip({super.key, this.cert});

  @override
  Widget build(BuildContext context) {
    final Color color = colorFromCert(cert!);
    return InputChip(
      isEnabled: true,
      label: Text(certTitleFromCert(cert!)),
      tooltip: certDescriptionFromCert(cert!, true),
      backgroundColor: color,
      avatar: Icon(
        iconFromCertType(cert!),
        color: textColorFromColor(color),
      ),
    );
  }
}
