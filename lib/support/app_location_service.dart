import 'package:geolocator/geolocator.dart';

class AppLocationService {
  static Future<bool> permissionHandlerLocation() async {
    try {
      LocationPermission locationPermission;
      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.denied) {
          return false;
        } else {
          return true;
        }
      } else if (locationPermission == LocationPermission.deniedForever) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<Position?> getCurrentPosition() async {
    try {
      bool serviceEnabled;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      } else {
        Position currentPosition = await Geolocator.getCurrentPosition();
        return currentPosition;
      }
    } catch (e) {
      return null;
    }
  }
}
