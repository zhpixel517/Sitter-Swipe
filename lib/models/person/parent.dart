import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sitter_swipe/models/person/person.dart';
import 'package:sitter_swipe/models/user_data.dart';
import 'package:sitter_swipe/resources/strings.dart';

/// Representation of a family from the database. Intentionally separated from [UserData]
class Parent extends Person {
  List<Map<String, String>>? children;
  String? willPayRate;

  Parent({
    this.children,
    this.willPayRate,
    String? name,
    GeoPoint? location,
    int? age,
    String? bio,
    String? gender,
    String? phoneNumber,
    List? reviews,
    double? stars,
    String? uid,
    List<String>? profileImageUrls,
  }) : super(
          name: name,
          location: location,
          age: age,
          bio: bio,
          gender: gender,
          phoneNumber: phoneNumber,
          reviews: reviews,
          stars: stars,
          uid: uid,
          profileImageUrls: profileImageUrls,
        );

  /// Converts a [Map] of data into a [Parent] object
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FirebaseDataPointKeys.children: children,
      FirebaseDataPointKeys.willPayRate: willPayRate,
      FirebaseDataPointKeys.fullName: name,
      FirebaseDataPointKeys.location: location,
      FirebaseDataPointKeys.age: age,
      FirebaseDataPointKeys.bio: bio,
      FirebaseDataPointKeys.gender: gender,
      FirebaseDataPointKeys.phoneNumber: phoneNumber,
      FirebaseDataPointKeys.reviews: reviews,
      FirebaseDataPointKeys.stars: stars,
      FirebaseDataPointKeys.uid: uid,
      FirebaseDataPointKeys.profileImages: profileImageUrls,
    };
  }

  /// Returns a [Sitter] object from a [Map]
  factory Parent.fromMap(Map<String, dynamic> map) {
    return Parent(
      children: map[FirebaseDataPointKeys.children] != null
          ? map[FirebaseDataPointKeys.children] as List<Map<String, String>>
          : null,
      willPayRate: map[FirebaseDataPointKeys.willPayRate] != null
          ? map[FirebaseDataPointKeys.willPayRate] as String
          : null,
      name: map[FirebaseDataPointKeys.fullName] != null
          ? map[FirebaseDataPointKeys.fullName] as String
          : null,
      location: map[FirebaseDataPointKeys.location] != null
          ? map[FirebaseDataPointKeys.location] as GeoPoint
          : null,
      age: map[FirebaseDataPointKeys.age] != null
          ? map[FirebaseDataPointKeys.age] as int
          : null,
      bio: map[FirebaseDataPointKeys.bio] != null
          ? map[FirebaseDataPointKeys.bio] as String
          : null,
      gender: map[FirebaseDataPointKeys.gender] != null
          ? map[FirebaseDataPointKeys.gender] as String
          : null,
      phoneNumber: map[FirebaseDataPointKeys.phoneNumber] != null
          ? map[FirebaseDataPointKeys.phoneNumber] as String
          : null,
      reviews: map[FirebaseDataPointKeys.reviews] != null
          ? map[FirebaseDataPointKeys.reviews] as List
          : null,
      stars: map[FirebaseDataPointKeys.stars] != null
          ? map[FirebaseDataPointKeys.stars] as double
          : null,
      uid: map[FirebaseDataPointKeys.uid] != null
          ? map[FirebaseDataPointKeys.uid] as String
          : null,
      profileImageUrls: map[FirebaseDataPointKeys.profileImages] != null
          ? map[FirebaseDataPointKeys.profileImages] as List<String>
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Parent.fromJson(String source) =>
      Parent.fromMap(json.decode(source) as Map<String, dynamic>);
}
