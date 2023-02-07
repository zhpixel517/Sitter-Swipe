import 'package:sitter_swipe/models/enums/prefferred_gender.dart';
import 'package:flutter/material.dart';

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
  final bool? isFamily;
  final bool? isSitter;
  final List? reviews;
  final String? phoneNumber;
  final String? uid;
  final String? city;
  final String? stateOrProvince;

  UserData(
      {this.fullName,
      this.userName,
      this.age,
      this.location,
      this.gender,
      this.profileImages,
      this.profilePicture,
      this.stars,
      this.isFamily,
      this.isSitter,
      this.phoneNumber,
      this.city,
      this.stateOrProvince,
      this.uid,
      this.reviews});
}

// save the user data from firebase into a data class

// send this data back to firebase as well when registering?

class ThisUser {
  final String? uid;
  final UserData? userData = null; // TODO: add access to this user's data?
  ThisUser({this.uid});
}

ThisUser? globalThisUser;
// TODO: put this user's data into App Preferences
