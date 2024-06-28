import 'package:geolocator/geolocator.dart';

class CustomLocation {
  Future<bool> _isServiceAvailable() async =>
      await Geolocator.isLocationServiceEnabled();

  _isPermissionGranted() async {
    LocationPermission permission = await Geolocator.checkPermission();
    switch (permission) {
      case LocationPermission.denied:
      case LocationPermission.deniedForever:
        return false;
      default:
        return true;
    }
  }

  _grantPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception("permission-denied");
    } else if (permission == LocationPermission.deniedForever) {
      throw Exception("permission-denied_for_ever");
    }
  }

  Future<void> accessLocation(
      {required Function(String position) callBack}) async {
    if (!await _isServiceAvailable()) {
      throw Exception("service-not_available");
    }

    if (!await _isPermissionGranted()) {
      await _grantPermission();
    }
    final Position position = await Geolocator.getCurrentPosition();

    // var res =
    //     await placemarkFromCoordinates(position.latitude, position.longitude);

    // print("\n\n Trace: ==============================================");
    // print("\nLatitude: ${position.latitude}");
    // print("\nLongitude: ${position.longitude}");
    // print("\nAddress: ${res.toString()}");
    // print("End-Trace: ==============================================\n\n ");
    callBack("${position.latitude},${position.longitude}");
  }
}
