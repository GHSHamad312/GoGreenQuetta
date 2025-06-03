import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RouteDetailScreen extends StatelessWidget {
  final Map<String, dynamic> route;

  const RouteDetailScreen({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    final stops = route['stops'] as List<Map<String, dynamic>>;
    final points = stops.map((s) => s['latlng'] as LatLng).toList();
    final stopNames = stops.map((s) => s['name'].toString()).toList();
    final timings = route['timings'] as List;

    return Scaffold(
      appBar: AppBar(
        title: Text('${route['busNumber']} - ${route['routeName']}'),
        backgroundColor: Colors.green.shade600,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 400,
            child: FlutterMap(
              options: MapOptions(
                center: points.isNotEmpty ? points[0] : LatLng(0, 0),
                zoom: 13,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.greenbus',
                ),
                MarkerLayer(
                  markers:
                      stops.map((stop) {
                        return Marker(
                          point: stop['latlng'],
                          width: 40,
                          height: 40,
                          builder:
                              (_) => Icon(
                                Icons.location_pin,
                                color: const Color.fromARGB(255, 22, 210, 72),
                                size: 36,
                              ),
                        );
                      }).toList(),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView.separated(
                    itemCount: timings.length,
                    separatorBuilder: (_, __) => const Divider(height: 16),
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              stopNames[index],
                              style: const TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            timings[index].toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
