//? list with certifications that people can add

import 'package:flutter/material.dart';
import 'package:sitter_swipe/resources/colors.dart';
import 'package:sitter_swipe/resources/strings.dart';

enum Skill {
  basicCooking,
  glutenFreeCooking,
  cookingAccomodations,
  pets,
  childCare,
  infants,
  diaperChanging,
  afterSchool,
  toddlers,
  houseKeeping,
}

class SkillColors {
  static const Color amber = Color(0xFFffbf00);
  static const Color cerise = Color(0xFFe83f6f);
  static const Color uclaBlue = Color(0xFF2274a5);
  static const Color seaGreen = Color(0xFF32936f);
  static const Color muave = Color(0xFFedc9ff);
  static const Color sitterSwipeTan = TanPallete.tan;
  static const Color chiliRed = Color(0xFFea2b1f);
  static const Color royalBlue = Color(0xFF0a2463);
  static const Color sandyBrown = Color(0xFFf09d51);
  static const Color feldgrau = Color(0xFF3a4f41);
}

/// Returns the correct description if depending on the inputted skill type
/// if [viewing] is true, this will return the correct string from the [SkillDescriptionsForViewer] class
/// if [viewing] is not true, this will return the correct string from the [SkillDescriptionsForRegistee] class.
String skillDescriptionFromSkill(Skill skill, bool viewing) {
  switch (skill) {
    case Skill.basicCooking:
      return viewing
          ? SkillDescriptionsForViewer.basicCooking
          : SkillDescriptionsForViewer.basicCooking;
    case Skill.pets:
      return viewing
          ? SkillDescriptionsForViewer.pets
          : SkillDescriptionsForViewer.pets;
    case Skill.childCare:
      return viewing
          ? SkillDescriptionsForViewer.childCare
          : SkillDescriptionsForViewer.childCare;
    case Skill.infants:
      return viewing
          ? SkillDescriptionsForViewer.infants
          : SkillDescriptionsForViewer.infants;
    case Skill.diaperChanging:
      return viewing
          ? SkillDescriptionsForViewer.diaperChanging
          : SkillDescriptionsForViewer.diaperChanging;
    case Skill.afterSchool:
      return viewing
          ? SkillDescriptionsForViewer.afterSchool
          : SkillDescriptionsForViewer.afterSchool;
    case Skill.toddlers:
      return viewing
          ? SkillDescriptionsForViewer.toddlers
          : SkillDescriptionsForViewer.toddlers;
    case Skill.houseKeeping:
      return viewing
          ? SkillDescriptionsForViewer.houseKeeping
          : SkillDescriptionsForViewer.houseKeeping;
    case Skill.glutenFreeCooking:
      return viewing
          ? SkillDescriptionsForViewer.glutenFreeCooking
          : SkillDescriptionsForViewer.glutenFreeCooking;
    case Skill.cookingAccomodations:
      return viewing
          ? SkillDescriptionsForViewer.cookingAccomodations
          : SkillDescriptionsForViewer.cookingAccomodations;
    default:
      return "";
  }
}

/// Returns the skill title from [Skill]
String skillTitleFromSkill(Skill skill) {
  switch (skill) {
    case Skill.basicCooking:
      return SkillNames.cooking;
    case Skill.glutenFreeCooking:
      return SkillNames.glutenFreeCooking;
    case Skill.cookingAccomodations:
      return SkillNames.cookingAccomodations;
    case Skill.pets:
      return SkillNames.pets;
    case Skill.childCare:
      return SkillNames.childCare;
    case Skill.infants:
      return SkillNames.infants;
    case Skill.diaperChanging:
      return SkillNames.diaperChanging;
    case Skill.afterSchool:
      return SkillNames.afterSchool;
    case Skill.toddlers:
      return SkillNames.toddlers;
    case Skill.houseKeeping:
      return SkillNames.houseKeeping;
    default:
      return "";
  }
}

/// Returns an icon depending on the inputted [Skill]
IconData iconFromSkillType(Skill skill) {
  switch (skill) {
    case Skill.basicCooking:
      return Icons.dinner_dining_outlined;
    case Skill.glutenFreeCooking:
      return Icons.dinner_dining_outlined;
    case Skill.cookingAccomodations:
      return Icons.dinner_dining_outlined;
    case Skill.pets:
      return Icons.pets_outlined;
    case Skill.childCare:
      return Icons.escalator_warning_outlined;
    case Skill.infants:
      return Icons.child_friendly_outlined;
    case Skill.diaperChanging:
      return Icons.baby_changing_station_outlined;
    case Skill.afterSchool:
      return Icons.school;
    case Skill.toddlers:
      return Icons.child_care_outlined;
    case Skill.houseKeeping:
      return Icons.home;
  }
}

/// Returns a color depending on the [Skill]
Color colorFromSkill(Skill skill) {
  switch (skill) {
    case Skill.basicCooking:
      return SkillColors.amber;
    case Skill.pets:
      return SkillColors.cerise;
    case Skill.childCare:
      return SkillColors.feldgrau;
    case Skill.infants:
      return SkillColors.muave;
    case Skill.diaperChanging:
      return SkillColors.royalBlue;
    case Skill.afterSchool:
      return SkillColors.uclaBlue;
    case Skill.toddlers:
      return SkillColors.sandyBrown;
    case Skill.houseKeeping:
      return SkillColors.chiliRed;
    case Skill.glutenFreeCooking:
      return SkillColors.sitterSwipeTan;
    case Skill.cookingAccomodations:
      return SkillColors.seaGreen;
    default:
      return Colors.white;
  }
}

/// Either black or white depending on the inputted [Color]
Color textColorFromColor(Color color) {
  List<Color> shouldBeWhiteText = [
    SkillColors.cerise,
    SkillColors.uclaBlue,
    SkillColors.seaGreen,
    SkillColors.sitterSwipeTan,
    SkillColors.chiliRed,
    SkillColors.royalBlue,
    SkillColors.feldgrau
  ];
  List<Color> shouldBeBlackText = [
    SkillColors.amber,
    SkillColors.muave,
    SkillColors.sandyBrown
  ];
  assert(shouldBeWhiteText.length + shouldBeBlackText.length == 10);
  if (shouldBeWhiteText.contains(color)) {
    return Colors.white;
  } else {
    return Colors.black;
  }
}
