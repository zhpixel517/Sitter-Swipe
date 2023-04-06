import 'package:sitter_swipe/models/enums/prefferred_gender.dart';

class UserData {
  /*

  All the attributes and datapoints that a user can have.
  This will go to firestore

  */

  final String? fullName;
  final String? userName; // ex: @something
  final int? age;
  final dynamic location; // TODO: add a location identifier or a coordinate
  final PreferredGender? gender; // TODO: convert this to a string for firebase
  final List? profileImages; // TODO: image locators from firebase of the person
  final String? profilePicture;
  final double? stars;
  final bool? isSitter;
  final List? reviews;
  final String? phoneNumber;
  final String? uid;
  final String? city;
  final String? stateOrProvince;
  final String? country;
  final List<String>? likes;

  UserData({
    required this.fullName,
    required this.userName,
    required this.age,
    required this.location,
    required this.gender,
    required this.profileImages,
    required this.profilePicture,
    required this.stars,
    required this.isSitter,
    required this.phoneNumber,
    required this.city,
    required this.stateOrProvince,
    required this.uid,
    required this.country,
    required this.reviews,
    this.likes,
  });
}

// save the user data from firebase into a data class

// send this data back to firebase as well when registering?

class ThisUser {
  final String? uid;
  final UserData? userData; // TODO: add access to this user's data?
  ThisUser({this.uid, this.userData});
}

ThisUser? globalThisUser;
// TODO: put this user's data into App Preferences
