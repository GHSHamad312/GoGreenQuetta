import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../../Providers/routeprovider.dart';

class NearestBusWidget extends StatefulWidget {
  @override
  _NearestBusWidgetState createState() => _NearestBusWidgetState();
}

class _NearestBusWidgetState extends State<NearestBusWidget> {
  String? nearestBusInfo;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
  }

  Future<void> findNearestBusStop() async {
    setState(() => isLoading = true);

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      LatLng userLocation = LatLng(position.latitude, position.longitude);

      final routeProvider = Provider.of<RouteProvider>(context, listen: false);
      final Distance distance = Distance();

      double minDistance = double.infinity;
      String? nearestBus;
      String? nearestStop;

      for (var route in routeProvider.routes) {
        for (var stop in route['stops']) {
          final stopLocation = stop['latlng'] as LatLng;
          final double d = distance(userLocation, stopLocation);
          if (d < minDistance) {
            minDistance = d;
            nearestBus = route['busNumber'];
            nearestStop = stop['name'];
          }
        }
      }

      if (nearestBus != null && nearestStop != null) {
        setState(() {
          nearestBusInfo =
              "Nearest Bus: $nearestBus\nStop: $nearestStop\nDistance: ${minDistance.toStringAsFixed(0)} meters";
        });
      } else {
        setState(() {
          nearestBusInfo = "No nearby buses found.";
        });
      }
    } catch (e) {
      setState(() {
        nearestBusInfo = "Failed to get location or find bus: $e";
      });
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.directions_bus, size: 60, color: Colors.green),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: isLoading ? null : findNearestBusStop,
                icon: Icon(Icons.location_searching, color: Colors.white),

                label: Text(
                  "Find Nearest Bus",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                ),
              ),
              SizedBox(height: 20),
              if (isLoading) CircularProgressIndicator(),
              if (nearestBusInfo != null) ...[
                SizedBox(height: 20),
                Text(
                  nearestBusInfo!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
