import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// Models.
import '/data/models/failure.dart';

class LocationRepository {
  /// This method can be used to request location permissions.
  /// * should be used in a try catch block
  /// * throws failures if permission is not valid
  Future<void> requestLocationPermissions() async {
    // Check if user has location service enabled.
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // User disabled Location service.
    if (serviceEnabled == false) throw Failure.locationServiceDisabled();

    // Request permission.
    final LocationPermission permissionStatus = await Geolocator.requestPermission();

    // Permissions have been granted always.
    if (permissionStatus == LocationPermission.always) return;

    // Permissions have been granted while in use.
    if (permissionStatus == LocationPermission.whileInUse) return;

    // User denied permission forever.
    if (permissionStatus == LocationPermission.deniedForever) throw Failure.locationPermissionDeniedForever();

    // User denied permission.
    if (permissionStatus == LocationPermission.denied) throw Failure.locationPermissionDenied();

    // An unexpected requestPermission has been returned. Output debug message.
    debugPrint("LocationRepository --> requestLocationPermissions() --> unexpected PermissionStatus: ${permissionStatus.toString()}");

    throw Failure.locationPermissionError();
  }

  /// This method can be used to access the current user location.
  /// * should be used in a try catch block
  Future<Map<String, dynamic>> getCurrentUserLocation() async {
    // Access current device location data.
    final Position locationData = await Geolocator.getCurrentPosition();

    return {
      'lat': locationData.latitude.toString(),
      'lng': locationData.longitude.toString(),
      'type': 'Point',
    };
  }
}
