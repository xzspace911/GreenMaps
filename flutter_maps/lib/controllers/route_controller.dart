import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import '../utils/colors.dart';

class RouteController {
  List<LatLng> routePoints = [];
  List<Marker> markers = [];
  final String apiKey = '5b3ce3597851110001cf62482a3bbccce840449baea616641f870310';

  Future<void> getRoute(LocationData? location, LatLng destination) async {
    if (location == null) return;

    final start = LatLng(location.latitude!, location.longitude!);
    final response = await http.get(Uri.parse(
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final coords = data['features'][0]['geometry']['coordinates'] as List;
      routePoints = coords.map((c) => LatLng(c[1], c[0])).toList();
      markers.add(_createMarker(destination, XColors.extraLightColor));
    } else {
      debugPrint('Route fetch failed');
    }
  }

  void addDestinationMarker(LatLng point) {
    markers.add(_createMarker(point, Colors.red));
  }

  Marker _createMarker(LatLng point, Color color) {
    return Marker(
      width: 80.0,
      height: 80.0,
      point: point,
      child: Icon(Icons.location_pin, color: color, size: 40),
    );
  }
}
