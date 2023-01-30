import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:sitter_swipe/models/base_viewmodel.dart';
import 'package:geolocator/geolocator.dart';

class SwipeViewModel extends BaseViewModel with SwipeViewModelOutput {
  final StreamController _cityName = StreamController<String>.broadcast();

  @override
  void dispose() {
    // TODO: implement dispose
  }

  void getUserFeed() async {
    // find matches based off of discovery preferences from firebase
    // send them via stream into the view
  }

  void getCityName() async {
    LocationPermission locationPermissionStatus =
        await Geolocator.checkPermission();
    if (locationPermissionStatus == LocationPermission.whileInUse ||
        locationPermissionStatus == LocationPermission.always) {
      // TODO: get the location and send it to the view
      Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.bestForNavigation)
          .timeout(const Duration(seconds: 10));
      try {
        List<Placemark> placeMark = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        print("The returned placemark is $placeMark");
        _cityName.add(placeMark);
        // give this to the viewmodel
      } catch (error) {
        print(error);
      }
    }
  }

  @override
  void start() async {
    getCityName();
    getUserFeed();
  }
}

abstract class SwipeViewModelOutput {
  // Stream<List> get sittersListOutput;
}
