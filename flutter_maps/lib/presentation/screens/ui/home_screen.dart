import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_maps/presentation/widgets/custom_app_bar.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_maps/controllers/location_controller.dart';
import 'package:flutter_maps/controllers/route_controller.dart';
import 'package:flutter_maps/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MapController mapController = MapController();
  final LocationController _locationController = LocationController();
  final RouteController _routeController = RouteController();
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _locationController.initializeLocation(context, () {
      setState(() {});
    });
  }

  void _onMapTap(LatLng point) async {
    setState(() {
      _routeController.addDestinationMarker(point);
    });
    await _routeController.getRoute(_locationController.currentLocation, point);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: XColors.darkBackgroundColor,
      appBar: CustomAppBar(
        selectedTabIndex: _selectedTabIndex,
        onTabSelected: (index) {
          setState(() => _selectedTabIndex = index);
        },
      ),
      body: _locationController.currentLocation == null
          ? const Center(
              child: CircularProgressIndicator(color: XColors.extraLightColor))
          : FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: _locationController.currentLatLng,
                initialZoom: 17,
                onTap: (_, point) => _onMapTap(point),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: _routeController.markers),
                if (_routeController.routePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: _routeController.routePoints,
                        strokeWidth: 4.0,
                        color: XColors.lemonColor,
                      ),
                    ],
                  ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: XColors.extraLightColor,
        onPressed: () {
          if (_locationController.currentLocation != null) {
            mapController.move(_locationController.currentLatLng, 15.0);
          }
        },
        child:
            const Icon(Icons.location_pin, color: XColors.darkBackgroundColor),
      ),
    );
  }
}
