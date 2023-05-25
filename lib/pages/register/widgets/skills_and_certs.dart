import 'package:flutter/material.dart';
import 'package:sitter_swipe/models/skills.dart';
import 'package:sitter_swipe/resources/fonts.dart';

/// Skill chip for registration
class SkillChipRegister extends StatelessWidget {
  final Skill? skill;
  const SkillChipRegister({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    final Color color = colorFromSkill(skill!);
    return InputChip(
      backgroundColor: color,
      avatar: Icon(iconFromSkillType(skill!), color: textColorFromColor(color)),
      label: Text(skillDescriptionFromSkill(skill!, false)),
      labelStyle: Fonts.smallText.copyWith(color: textColorFromColor(color)),
    );
  }
}

/// Certification chip for registration
class CertificationChipRegister extends StatelessWidget {
  final Skill? skill;
  const CertificationChipRegister({super.key, this.skill});

  @override
  Widget build(BuildContext context) {
    final Color color = colorFromSkill(skill!);
    return InputChip(
      backgroundColor: color,
      avatar: Icon(iconFromSkillType(skill!), color: textColorFromColor(color)),
      label: Text(skillDescriptionFromSkill(skill!, false)),
      labelStyle: Fonts.smallText.copyWith(color: textColorFromColor(color)),
    );
  }
}
