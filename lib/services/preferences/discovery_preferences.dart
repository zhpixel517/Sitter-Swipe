import 'package:sitter_swipe/models/enums/prefferred_gender.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:sitter_swipe/services/di.dart';

class DiscoveryPreferences {
  int? range; //25;
  double? minimumRating; // = 3.5;
  PreferredGender? preferredGender; // only if lookingForSitter is true
  int? minAge;
  int? maxAge;
  Map? skillsAndCerts; // TODO: implement pref saving

  DiscoveryPreferences(
      {this.range,
      this.minimumRating,
      this.preferredGender,
      this.minAge,
      this.maxAge});

  void save() async {
    final prefs = instance<SharedPreferences>();
    String stringFormOfGenderEnum =
        EnumToString.convertToString(preferredGender!);
    prefs.setInt(DiscoveryPreferencesKeys.range, range!);
    prefs.setDouble(DiscoveryPreferencesKeys.minimumRating, minimumRating!);
    prefs.setString(
        DiscoveryPreferencesKeys.preferredGender, stringFormOfGenderEnum);
    prefs.setInt(DiscoveryPreferencesKeys.minAge, minAge!);
    prefs.setInt(DiscoveryPreferencesKeys.maxAge, maxAge!);
  }
}

Future<DiscoveryPreferences> getDiscoveryPreferences() async {
  final prefs = instance<SharedPreferences>();
  int? range = prefs.getInt(DiscoveryPreferencesKeys.range) ??
      DiscoveryDefaultValues.range;

  double? minimumRating =
      prefs.getDouble(DiscoveryPreferencesKeys.minimumRating) ??
          DiscoveryDefaultValues.minimumRating;

  PreferredGender? preferredGender = EnumToString.fromString(
      PreferredGender.values,
      prefs.getString(DiscoveryPreferencesKeys.preferredGender) ?? "any");

  int? minAge = prefs.getInt(DiscoveryPreferencesKeys.minAge) ??
      DiscoveryDefaultValues.minAge;

  int? maxAge = prefs.getInt(DiscoveryPreferencesKeys.maxAge) ??
      DiscoveryDefaultValues.maxAge;

  return DiscoveryPreferences(
      range: range,
      minimumRating: minimumRating,
      preferredGender: preferredGender,
      minAge: minAge,
      maxAge: maxAge);
}

class DiscoveryPreferencesKeys {
  static const String range = 'range';
  static const String minimumRating = 'minimum_rating';
  static const String preferredGender = "preferred_gender";
  static const String minAge = "min_age";
  static const String maxAge = "max_age";
}

class DiscoveryDefaultValues {
  static const int range = 25;
  static const double minimumRating = 3.5;
  static const PreferredGender preferredGender = PreferredGender.any;
  static const int minAge = 4;
  static const int maxAge = 11;
}
