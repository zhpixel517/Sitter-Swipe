import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sitter_swipe/services/functions/units.dart';

Future<Position> getCurrentPosition() async {
  Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation)
      .timeout(const Duration(seconds: 10));
  return position;
}

Future<Location> getCoordinatesFromAddress(String address) async {
  List<Location> locations = await locationFromAddress(address);
  return locations.first;
}

int calculateDistance(Position location1, GeoPoint location2) {
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
    Position position = await getCurrentPosition();
    try {
      List<Placemark> placeMark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      // give this to the viewmodel
      return placeMark;
    } catch (error) {
      print("Returned nothing because there was an error");
      print("The error was $error");
      return [];
    }
  } else {
    print("Returned nothing since the permission wasn't granted");
    return [];
  }
}
