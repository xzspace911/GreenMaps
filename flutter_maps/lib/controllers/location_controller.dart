import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

class LocationController {
  LocationData? currentLocation;
  final Location location = Location();

  Future<void> initializeLocation(BuildContext context, VoidCallback onLoaded) async {
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled && !(await location.requestService())) return;

      PermissionStatus permission = await location.hasPermission();
      if (permission == PermissionStatus.denied &&
          (await location.requestPermission()) != PermissionStatus.granted) return;

      currentLocation = await location.getLocation();
      onLoaded();
    } catch (e) {
      debugPrint('Location error: $e');
    }
  }

  LatLng get currentLatLng =>
      LatLng(currentLocation?.latitude ?? 0, currentLocation?.longitude ?? 0);
}
