import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../../Providers/routeprovider.dart';

class NearestBusWidget extends StatefulWidget {
  const NearestBusWidget({super.key});

  @override
  State<NearestBusWidget> createState() => _NearestBusWidgetState();
}

class _NearestBusWidgetState extends State<NearestBusWidget> {
  LatLng? userLocation;
  LatLng? stopLocation;
  String? nearestBus;
  String? nearestStop;
  double? distanceMeters;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }
  }

  Future<void> findNearestBus() async {
    setState(() {
      isLoading = true;
      nearestBus = null;
      nearestStop = null;
      stopLocation = null;
      distanceMeters = null;
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      userLocation = LatLng(position.latitude, position.longitude);

      final routeProvider = Provider.of<RouteProvider>(context, listen: false);
      final Distance distance = const Distance();

      double closest = double.infinity;

      for (var route in routeProvider.routes) {
        final busNum = route['busNumber'];
        for (var stop in route['stops']) {
          final stopLatLng = stop['latlng'] as LatLng;
          final d = distance.as(LengthUnit.Meter, userLocation!, stopLatLng);

          if (d < closest) {
            closest = d;
            nearestBus = busNum;
            nearestStop = stop['name'];
            stopLocation = stopLatLng;
            distanceMeters = d;
          }
        }
      }

      if (nearestBus == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No nearby buses found.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final timeEstimate =
        distanceMeters != null
            ? (distanceMeters! / 80).toStringAsFixed(0)
            : null;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton.icon(
        onPressed: isLoading ? null : findNearestBus,
        icon: const Icon(Icons.my_location, color: Colors.white),
        label: const Text(
          "Find Nearest Stop",
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          backgroundColor: Colors.green.shade800,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 6,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (nearestBus != null &&
                nearestStop != null &&
                distanceMeters != null)
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.directions_bus,
                            color: Colors.green.shade800,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "$nearestBus",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      InfoRow(title: "Stop", value: nearestStop!),
                      InfoRow(
                        title: "Distance",
                        value: "${distanceMeters!.toStringAsFixed(0)} meters",
                      ),
                      if (timeEstimate != null)
                        InfoRow(title: "ETA", value: "$timeEstimate min walk"),
                      const SizedBox(height: 10),
                      Chip(
                        label: Text(
                          distanceMeters! <= 500
                              ? "🚶 Very Close"
                              : "📍 A bit Far",
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor:
                            distanceMeters! <= 500
                                ? Colors.green
                                : Colors.orange,
                      ),
                    ],
                  ),
                ),
              )
            else
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: Theme.of(context).hintColor,
                        size: 40,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Tap the button below to find your nearest bus stop.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.color?.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 16),
            if (userLocation != null && stopLocation != null)
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FlutterMap(
                    options: MapOptions(center: userLocation, zoom: 14),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        userAgentPackageName: 'com.example.greenbus',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: userLocation!,
                            width: 40,
                            height: 40,
                            builder:
                                (_) => Icon(
                                  Icons.person_pin_circle,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 36,
                                ),
                          ),
                          Marker(
                            point: stopLocation!,
                            width: 40,
                            height: 40,
                            builder:
                                (_) => Icon(
                                  Icons.location_on,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 36,
                                ),
                          ),
                        ],
                      ),
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: [userLocation!, stopLocation!],
                            strokeWidth: 4,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            "$title:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 15,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(
                  context,
                ).textTheme.bodyMedium?.color?.withOpacity(0.6),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
