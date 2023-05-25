import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:sitter_swipe/models/base_viewmodel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sitter_swipe/models/person/person.dart';
import 'package:sitter_swipe/models/person/sitter.dart';
import 'package:sitter_swipe/pages/swipe/widgets/card_content.dart';
import 'package:sitter_swipe/services/firebase/database.dart';
import 'package:sitter_swipe/services/functions/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sitter_swipe/services/preferences/app_preferences.dart';
import 'package:sitter_swipe/services/preferences/discovery_preferences.dart';

class SwipeViewModel extends BaseViewModel
    with SwipeViewModelOutput, SwipeViewModelInputs, ChangeNotifier {
  /*

  This is another method of using a viewmodel
  this is the way that I learned first.
  It's not the best and a little bit overkill for this usercase,
  but it works.

  */

  String? cityName;
  String? stateName;
  // List<DocumentSnapshot> userList =
  //   []; // should be either sitters or parents depending on something else?
  List<CardContent> userList = [];

  List<Person> _foundUsers = [];

  List<CardContent> get foundUsers => userList;

  final SitterDatabase database = SitterDatabase();

  // SETTERS

  void setCityName(String city) {
    cityName = city;
    notifyListeners();
  }

  void setStateOrProvinceName(String stateOrProvinceName) {
    stateName = stateOrProvinceName;
    notifyListeners();
  }

  void setUserList(foundUserList) {
    //List<DocumentSnapshot> foundUserList) {
    userList = foundUserList;
    print("set user list");
    notifyListeners();
  }

  void addToUserList(DocumentSnapshot snapshot) {
    // userList.add(snapshot);
    notifyListeners();
  }

  // GETTERS

  /// Generate the user's feed.
  /// Should take into account all of the user's preferences
  Future<void> getUserFeed(bool currentUserIsSitter) async {
    final DiscoveryPreferences prefs = await getDiscoveryPreferences();
    Position position = await Geolocator.getCurrentPosition();
    GeoFirePoint center = GeoFlutterFire().point(
      latitude: position.latitude,
      longitude: position.longitude,
    );

    var testStream =
        database.testLocationQuery(center, prefs.range!.toDouble());

    testStream.listen((List<DocumentSnapshot> documentSnapshots) {
      _foundUsers = documentSnapshots.map((doc) {
        return Sitter.fromMap(doc.data()! as Map<String, dynamic>);
      }).toList();

      List<CardContent> feed = _foundUsers.map((person) {
        int distanceInMiles = calculateDistance(position, person.location!);
        return CardContent(
          image: person.profileImageUrls![0],
          userName: "",
          fullName: person.name,
          age: person.age.toString(),
          rating: person.stars,
          distance: distanceInMiles.toString(),
          hourlyRate: "",
          isFamily: false,
          alignment: Alignment.center,
        );
      }).toList();

      setUserList(feed);
    });
  }

  // HELPER FUNCTIONS

  /// Sorts found users and returns users that match the given discovery preferences criteria
  filter() {}

  final StreamController _cityName = StreamController<String>.broadcast();
  final StreamController _stateName = StreamController<String>.broadcast();
  final StreamController _sittersList = StreamController.broadcast();

  @override
  Sink get inputCityName => _cityName.sink;

  @override
  Sink get inputStateProvinceName => _stateName.sink;

  @override
  Sink get inputSittersList => _sittersList.sink;

  @override
  Stream get outputCityName => _cityName.stream;

  @override
  Stream get outputStateProvinceName => _stateName.stream;

  @override
  Stream get sittersListOutput => _sittersList.stream;

  @override
  void dispose() {}

/*
  Future<QuerySnapshot> getUserFeed() {
    // find matches based off of discovery preferences from firebase
    // send them via stream into the view
    return database.userList; // TODO: get nearby users
  }
  */

  /*
  Future<void> loadUserList() async {
    await getUserFeed(false); // TODO: check if we are sitter or parent first
    Position position = await Geolocator.getCurrentPosition(); // test
    double radius = 10.0; //miles
    GeoFirePoint center = GeoFlutterFire()
        .point(latitude: position.latitude, longitude: position.longitude);
    Stream<List<DocumentSnapshot<Object?>>> test =
        SitterDatabase().testLocationQuery(center, radius);

    inputSittersList.add(test);
  }
  */

  Future<void> requestNeededPermissions() async {
    await [Permission.location].request();
  }

  @override
  void start() async {
    await requestNeededPermissions();
    if (saveUserCity == null && saveUserStateOrProvince == null) {
      List cities = await getCityName();
      String? userCity = cities[0].locality;
      String? userState = cities[0].administrativeArea;
      inputCityName.add(userCity);
      inputStateProvinceName.add(userState);
      saveUserCity = userCity;
      saveUserStateOrProvince = userState;
      // TODO: chage depending on if we are sitter or a parent

      //await testLoadSitters();
    } else {
      inputCityName.add(saveUserCity);
      inputStateProvinceName.add(saveUserStateOrProvince);
    }
    //var userList = getUserFeed();
    //inputSittersList.add(userList);
    print("getting user feed!");
    await getUserFeed(true);
  }
}

abstract class SwipeViewModelInputs {
  Sink get inputCityName;
  Sink get inputStateProvinceName;
  Sink get inputSittersList;
}

abstract class SwipeViewModelOutput {
  Stream get sittersListOutput;
  Stream get outputCityName;
  Stream get outputStateProvinceName;
}
