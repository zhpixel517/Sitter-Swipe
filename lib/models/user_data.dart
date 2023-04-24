import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  /*

  All the attributes and datapoints that a user can have.
  This will go to firestore

  */

  final String? fullName;
  final String? userName; // ex: @something
  final int? age;
  final GeoPoint location; // TODO: add a location identifier or a coordinate
  final String? gender; // TODO: convert this to a string for firebase
  List<File>? profileImages; // TODO: image locators from firebase of the person
  List<String>? profileImageDownloadUrls;
  final String? profilePicture;
  final double? stars;
  final bool? isSitter;
  final List? reviews;
  final String? phoneNumber;
  String? uid; // this will be set in a later function, so not final
  final String? city;
  final String? stateOrProvince;
  final String? country;
  final List<String>? likes;
  final String? bio;
  final String? availability;
  final String? willPayRate;
  final Map? children;

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
    this.uid, // set later. see services/firebase/auth.dart
    this.profileImageDownloadUrls, // set later. see services/firebase/auth.dart
    this.children, // only set if we are a parent
    required this.country,
    required this.reviews,
    required this.bio,
    required this.availability,
    required this.willPayRate,
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
