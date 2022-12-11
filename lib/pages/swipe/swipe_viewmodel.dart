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

  @override
  void start() async {
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
        // give this to the viewmodel
      } catch (error) {
        print(error);
      }
    }
  }
}

abstract class SwipeViewModelOutput {
  // Stream<List> get sittersListOutput;

}
