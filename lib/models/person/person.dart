// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sitter_swipe/models/person/child.dart';

/// Base class for a person discovered on the app. [Child] is not going to inherit from this class.
class Person {
  String? name;
  GeoPoint? location;
  int? age;
  String? bio;
  String? gender;
  String? phoneNumber;
  List? reviews;
  double? stars;
  String? uid;
  List<String>? profileImageUrls;

  Person(
      {this.name,
      this.location,
      this.age,
      this.bio,
      this.gender,
      this.phoneNumber,
      this.reviews,
      this.stars,
      this.uid,
      this.profileImageUrls});
}
