import 'package:sitter_swipe/models/enums/prefferred_gender.dart';

// use this data to make firebase data queries

class UserDefinedDiscoveryPreferences {
  // a family looking for a sitter
  final int range; // range of looking for sitters
  final PreferredGender preferredGender; // gender of the sitter
  final double minimumRating; // minimum amount of stars to look for
  final String cityName;
  // final double hourlyPay; // what the sitters charge???

  UserDefinedDiscoveryPreferences(
      {required this.range,
      required this.preferredGender,
      required this.cityName,
      required this.minimumRating});
}
