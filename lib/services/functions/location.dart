import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sitter_swipe/services/functions/units.dart';
import 'package:sitter_swipe/services/preferences/app_preferences.dart';

Future<Position> getCurrentPosition() async {
  Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation)
      .timeout(const Duration(seconds: 10));
  return position;
}

// TODO: calculate distance between 2 people's home addresses
// TODO: is this the right approach? firebase needs to know people's addresses
// when will the distance be calculated? check out https://pub.dev/packages/geoflutterfire

Future<int> calculateDistance(Position location1, Position location2) async {
  int distanceInMeters = Geolocator.distanceBetween(location1.latitude,
          location1.longitude, location2.latitude, location2.longitude)
      .round();
  return metersToMiles(distanceInMeters);
  // TODO: save the user's choice about units
}

Future<List<Placemark>> getCityName() async {
  LocationPermission locationPermissionStatus =
      await Geolocator.checkPermission();
  if (locationPermissionStatus == LocationPermission.whileInUse ||
      locationPermissionStatus == LocationPermission.always) {
    // TODO: get the location and send it to the view
    Position position = await getCurrentPosition();
    try {
      List<Placemark> placeMark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      // give this to the viewmodel
      return placeMark;
    } catch (error) {
      return [];
    }
  } else {
    return [];
  }
}
