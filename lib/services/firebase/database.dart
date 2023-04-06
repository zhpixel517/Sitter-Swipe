import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:sitter_swipe/models/user_data.dart';
import 'package:sitter_swipe/resources/strings.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sitter_swipe/services/di.dart';
import 'package:sitter_swipe/services/preferences/discovery_preferences.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';

class SitterDatabase {
  final String? uid;
  SitterDatabase({this.uid});

  // TODO: setup firebase
  // TODO: test firebase read and write

  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  final geo = GeoFlutterFire();

  Future updateUserData(UserData data) async {
    return await users.doc(uid).set({
      "fullName": data.fullName,
      "userName": data.userName,
      "age": data.age,
      "location": data.location,
      "gender": data.gender,
      "profileImages": data.profileImages,
      "profilePicture": data.profilePicture,
      "stars": data.stars,
      "isSitter": data.isSitter,
      "phoneNumber": data.phoneNumber,
      "reviews": data.reviews,
      "city": data.city,
      "stateOrProvince": data.stateOrProvince,
      "uid": uid,
      "likes": data.likes,
    });
  }

  UserData _thisUserDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        fullName: snapshot.get("fullName"),
        userName: snapshot.get("userName"),
        age: snapshot.get("age"),
        location: snapshot.get("location"),
        gender: snapshot.get("gender"),
        profileImages: snapshot.get("profileImages"),
        profilePicture: snapshot.get("profilePicture"),
        stars: snapshot.get("stars"),
        isSitter: snapshot.get("isSitter"),
        phoneNumber: snapshot.get("phoneNumber"),
        reviews: snapshot.get("reviews"),
        city: snapshot.get("city"),
        stateOrProvince: snapshot.get("stateOrProvince"),
        country: snapshot.get("country"),
        likes: snapshot.get("likes"),
        uid: uid);
  }

  List<UserData> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserData(
          country: doc.get("country"),
          fullName: doc.get("fullName"),
          userName: doc.get("userName"),
          age: doc.get("age"),
          location: doc.get("location"),
          gender: doc.get("gender"),
          profileImages: doc.get("profileImages"),
          profilePicture: doc.get("profilePicture"),
          stars: doc.get("stars"),
          isSitter: doc.get("isSitter"),
          phoneNumber: doc.get("phoneNumber"),
          reviews: doc.get("reviews"),
          city: doc.get("city"),
          stateOrProvince: doc.get("stateOrProvince"),
          uid: uid);
    }).toList();
  }

  filter(DiscoveryPreferences preferences, List<UserData> list) {
    return list.where((item) {
      if (item.location <=
              preferences.range && // TODO: how to calculate distance???
          item.stars! >= preferences.minimumRating! &&
          item.gender == preferences.preferredGender &&
          item.age! >= preferences.minAge! &&
          item.age! <= preferences.maxAge!) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<QuerySnapshot<Object?>> get foundSitters async {
    // TODO: where to implement discovery preferences?
    DiscoveryPreferences preferences = await getDiscoveryPreferences();
    var query = users
        .where("isSitter", isEqualTo: true)
        .where("age",
            isGreaterThanOrEqualTo: preferences.minAge,
            isLessThanOrEqualTo: preferences.maxAge)
        .where("stars", isGreaterThanOrEqualTo: preferences.minimumRating)
        .where("gender",
            isEqualTo:
                EnumToString.convertToString(preferences.preferredGender))
        .limit(30)
        .get();
    //TODO: geohashes

    /*
        .map(_userListFromSnapshot)
        .where((list) => filter(preferences, list)); 
        */
    return query;
  }

  Stream<List<UserData>> get foundFamilies {
    // TODO: where to implement the sitter side??
    return users.snapshots().map(_userListFromSnapshot);
  }

  // get this user's information
  Stream<UserData> userData() {
    return users.doc(uid).snapshots().map(_thisUserDataFromSnapshot);
  }

  // **********************************************************

  // functions for accessing this user's rejected and liked swiped users
  Future<List> getLikedUsers(bool thisUserIsFamily) async {
    if (thisUserIsFamily) {
      List likedSittersList = [];
      QuerySnapshot<Map<String, dynamic>> likedSitters = await FirebaseFirestore
          .instance
          .collection("sitters")
          .doc(uid)
          .collection("liked")
          .get();

      for (var item in likedSitters.docs) {
        likedSittersList.add(item);
      }
      return likedSittersList;
    } else {
      List likedFamiliesList = [];
      QuerySnapshot<Map<String, dynamic>> likedFamilies =
          await FirebaseFirestore.instance
              .collection("families")
              .doc(uid)
              .collection("liked")
              .get();
      for (var item in likedFamilies.docs) {
        likedFamiliesList.add(item);
      }
      return likedFamiliesList;
    }
  }

  Future<List> getPassedUsers(bool thisUserIsFamily) async {
    if (thisUserIsFamily) {
      List passedSittersList = [];
      QuerySnapshot<Map<String, dynamic>> passedSitters =
          await FirebaseFirestore.instance
              .collection("sitters")
              .doc(uid)
              .collection("passed")
              .get();

      for (var item in passedSitters.docs) {
        passedSittersList.add(item);
      }
      return passedSittersList;
    } else {
      List passedFamiliesList = [];
      QuerySnapshot<Map<String, dynamic>> passedFamilies =
          await FirebaseFirestore.instance
              .collection("families")
              .doc(uid)
              .collection("liked")
              .get();
      for (var item in passedFamilies.docs) {
        passedFamiliesList.add(item);
      }
      return passedFamiliesList;
    }
  }

  /*
  Future<bool> likeUser(dynamic thisUserId, dynamic otherUserID) async {
    // I need otherUserID so that the like notification will show on the other device
    await 
  }

  Future<bool> passUser() async {}
  */
}
