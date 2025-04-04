import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_maps/utils/colors.dart';
import 'package:flutter_maps/utils/strings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MapController mapController = MapController();
  LocationData? currentLocation;
  List<LatLng> routePoints = [];
  List<Marker> markers = [];
  final double initialZoom = 13.0;
  final String orsApiKey =
      '5b3ce3597851110001cf62482a3bbccce840449baea616641f870310';
  int _selectedTabIndex = 0;
  final List<IconData> _tabIcons = [Icons.home, Icons.favorite, Icons.person];
  final List<String> _tabLabels = ["Home", "Favorite", "Profile"];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    var location = Location();
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      var userLocation = await location.getLocation();
      if (userLocation.latitude != null && userLocation.longitude != null) {
        setState(() {
          currentLocation = userLocation;
          markers.add(
            Marker(
              point: LatLng(userLocation.latitude!, userLocation.longitude!),
              width: 80.0,
              height: 80.0,
              child:
                  const Icon(Icons.location_pin, color: Colors.red, size: 40),
            ),
          );
        });
      }
    } on Exception catch (e) {
      debugPrint('Location error: $e');
      setState(() {
        currentLocation = null;
      });
    }
  }

  Future<void> _getRoute(LatLng destination) async {
    if (currentLocation == null) return;
    final start =
        LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
    final response = await http.get(
      Uri.parse(
          'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$orsApiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> coords =
          data['features'][0]['geometry']['coordinates'];

      if (coords.isEmpty) {
        print('No route found');
        return;
      }

      setState(() {
        routePoints =
            coords.map((coord) => LatLng(coord[1], coord[0])).toList();
        markers.add(Marker(
          width: 80.0,
          height: 80.0,
          point: destination,
          child: const Icon(Icons.location_pin,
              color: XColors.extraLightColor, size: 40),
        ));
      });
    } else {
      print('Failed to fetch route');
    }
  }

  void _addDestinationMarker(LatLng point) {
    setState(() {
      markers.add(Marker(
        width: 80.0,
        height: 80.0,
        point: point,
        child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
      ));
    });
    _getRoute(point);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: XColors.darkBackgroundColor,
      appBar: AppBar(
        key: ValueKey("custom_appbar"),
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: XColors.white,
            )),
        leadingWidth: 60,
        backgroundColor: XColors.extraLightColor,
        automaticallyImplyLeading: false,
        title: Text("GreenMaps"),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: XStrings.poppinsFont,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: XColors.darkBackgroundColor,
        ),
        toolbarTextStyle: TextStyle(
          fontSize: 18,
          color: XColors.darkBackgroundColor,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
        actionsIconTheme: IconThemeData(color: XColors.white, size: 28),
        iconTheme: IconThemeData(color: XColors.lemonColor, size: 30),
        foregroundColor: XColors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: XColors.extraLightColor,
          ),
        ),
        forceMaterialTransparency: false,
        elevation: 6.0,
        scrolledUnderElevation: 8.0,
        shadowColor: Colors.black.withValues(alpha: 0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        notificationPredicate: (ScrollNotification notification) {
          return notification.depth == 0;
        },
        toolbarHeight: 80,
        titleSpacing: 30,
        toolbarOpacity: 0.95,
        bottomOpacity: 0.85,
        primary: true,
        excludeHeaderSemantics: false,
        clipBehavior: Clip.antiAlias,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(_tabIcons.length, (index) {
                      return _buildTabButton(index);
                    }),
                  ),
                )
              ],
            )),
      ),
      body: currentLocation == null || markers.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
              color: XColors.extraLightColor,
            ))
          : FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                initialZoom: 17,
                onTap: (tapPosition, point) => _addDestinationMarker(point),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: markers),
                if (routePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: routePoints,
                        strokeWidth: 4.0,
                        color: XColors.lemonColor,
                      ),
                    ],
                  ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (currentLocation != null) {
            mapController.move(
                LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                15.0);
          }
        },
        backgroundColor: XColors.extraLightColor,
        child: const Icon(
          Icons.location_pin,
          color: XColors.darkBackgroundColor,
        ),
      ),
    );
  }

  Widget _buildTabButton(int index) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Column(
        children: [
          Icon(
            _tabIcons[index],
            size: 28,
            color: isSelected ? XColors.darkBackgroundColor : XColors.white,
          ),
          SizedBox(height: 4),
          Text(
            _tabLabels[index],
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? XColors.darkBackgroundColor : XColors.white,
            ),
          ),
          if (isSelected)
            Container(
              margin: EdgeInsets.only(top: 4),
              height: 3,
              width: 30,
              color: XColors.lemonColor,
            )
        ],
      ),
    );
  }
}
