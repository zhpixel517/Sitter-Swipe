import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:sitter_swipe/models/base_viewmodel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sitter_swipe/models/user_data.dart';
import 'package:sitter_swipe/services/firebase/database.dart';
import 'package:sitter_swipe/services/functions/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sitter_swipe/services/preferences/app_preferences.dart';

class SwipeViewModel extends BaseViewModel
    with SwipeViewModelOutput, SwipeViewModelInputs {
  final StreamController _cityName = StreamController<String>.broadcast();
  final StreamController _stateName = StreamController<String>.broadcast();
  final StreamController _sittersList = StreamController<List>.broadcast();

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
  void dispose() {
    // TODO: implement dispose
  }

  Stream<List<UserData>> getUserFeed() {
    // find matches based off of discovery preferences from firebase
    // send them via stream into the view
    return SitterDatabase().foundFamilies; // TODO: get sitters
  }

  Future<void> requestNeededPermissions() async {
    await [Permission.location].request();
  }

  @override
  void start() async {
    await requestNeededPermissions();
    if (saveUserCity == null && saveUserStateOrProvince == null) {
      List<Placemark> cities = await getCityName();
      String? userCity = cities[0].locality;
      String? userState = cities[0].administrativeArea;
      inputCityName.add(userCity);
      inputStateProvinceName.add(userState);
      saveUserCity = userCity;
      saveUserStateOrProvince = userState;
      getUserFeed();
    } else {
      inputCityName.add(saveUserCity);
      inputStateProvinceName.add(saveUserStateOrProvince);
      getUserFeed();
    }
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
