import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:sitter_swipe/models/base_viewmodel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sitter_swipe/services/functions/location.dart';
import 'package:permission_handler/permission_handler.dart';

class SwipeViewModel extends BaseViewModel with SwipeViewModelOutput {
  final StreamController _cityName = StreamController<String>.broadcast();
  final StreamController _stateName = StreamController<String>.broadcast();

  // TODO: add recieving sinks

  @override
  void dispose() {
    // TODO: implement dispose
  }

  void getUserFeed() async {
    // find matches based off of discovery preferences from firebase
    // send them via stream into the view
  }

  Future<void> requestNeededPermissions() async {
    await [Permission.location].request();
  }

  @override
  void start() async {
    await requestNeededPermissions();
    List<Placemark> cities = await getCityName();
    String? userCity = cities[0].locality;
    String? userState = cities[0].administrativeArea;
    _cityName.add(userCity);
    _stateName.add(userState);
    getUserFeed();
  }
}

abstract class SwipeViewModelOutput {
  // Stream<List> get sittersListOutput;
}
