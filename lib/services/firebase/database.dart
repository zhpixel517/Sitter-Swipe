import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sitter_swipe/models/user_data.dart';
import 'package:sitter_swipe/services/preferences/discovery_preferences.dart';

class SitterDatabase {
  final String? uid;
  SitterDatabase({this.uid});

  // TODO: install and setup firebase
  // TODO: test firebase read and write

  final CollectionReference sitterCollection =
      FirebaseFirestore.instance.collection("sitters");
  final CollectionReference familiesCollection =
      FirebaseFirestore.instance.collection("families");

  Future updateUserData(UserData data) async {
    if (data.isFamily! == true && data.isSitter! == false) {
      return await familiesCollection.doc(uid).set({
        "fullName": data.fullName,
        "userName": data.userName,
        "age": data.age,
        "location": data.location,
        "gender": data.gender,
        "profileImages": data.profileImages,
        "profilePicture": data.profilePicture,
        "stars": data.stars,
        "isFamily": data.isFamily,
        "isSitter": data.isSitter,
        "phoneNumber": data.phoneNumber,
        "reviews": data.reviews,
        "city": data.city,
        "stateOrProvince": data.stateOrProvince,
        "uid": uid
      });
    } else {
      return await sitterCollection.doc(uid).set({
        "fullName": data.fullName,
        "userName": data.userName,
        "age": data.age,
        "location": data.location,
        "gender": data.gender,
        "profileImages": data.profileImages,
        "profilePicture": data.profilePicture,
        "stars": data.stars,
        "isFamily": data.isFamily,
        "isSitter": data.isSitter,
        "phoneNumber": data.phoneNumber,
        "reviews": data.reviews,
        "city": data.city,
        "stateOrProvince": data.stateOrProvince,
        "uid": uid
      });
    }
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
        isFamily: snapshot.get("isFamily"),
        isSitter: snapshot.get("isSitter"),
        phoneNumber: snapshot.get("phoneNumber"),
        reviews: snapshot.get("reviews"),
        city: snapshot.get("city"),
        stateOrProvince: snapshot.get("stateOrProvince"),
        uid: uid);
  }

  List<UserData> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserData(
          fullName: doc.get("fullName"),
          userName: doc.get("userName"),
          age: doc.get("age"),
          location: doc.get("location"),
          gender: doc.get("gender"),
          profileImages: doc.get("profileImages"),
          profilePicture: doc.get("profilePicture"),
          stars: doc.get("stars"),
          isFamily: doc.get("isFamily"),
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

  Future<Stream<List<UserData>>> get foundSitters async {
    // TODO: where to implement discovery preferences?
    DiscoveryPreferences preferences = await getDiscoveryPreferences();
    var collection = sitterCollection
        .snapshots()
        .map(_userListFromSnapshot)
        .where((list) => filter(preferences, list));
    return collection;
  }

  Stream<List<UserData>> get foundFamilies {
    // TODO: where to implement discovery preferences?
    return familiesCollection.snapshots().map(_userListFromSnapshot);
  }

  // get this user's information
  Stream<UserData> userData({bool? isFamily, bool? isSitter}) {
    if (isFamily! && isSitter! == false) {
      return familiesCollection
          .doc(uid)
          .snapshots()
          .map(_thisUserDataFromSnapshot);
    } else {
      return sitterCollection
          .doc(uid)
          .snapshots()
          .map(_thisUserDataFromSnapshot);
    }
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

  //! Thoughts: do I even need to separate families and sitters into two different collections?
  // doing it that way makes it hard to like / pass because I have to know where to look

  /*
  Future<bool> likeUser(dynamic thisUserId, dynamic otherUserID) async {
    // I need otherUserID so that the like notification will show on the other device
    await 
  }

  Future<bool> passUser() async {}
  */
}
