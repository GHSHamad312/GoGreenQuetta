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
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade800, Colors.green.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Bus icon
                  const Icon(
                    Icons.directions_bus_filled,
                    color: Colors.white,
                    size: 26,
                  ),
                  const SizedBox(width: 12),

                  // Title section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                          MainAxisAlignment.center, // center vertically
                      children: [
                        Text(
                          '${route['busNumber']}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          route['routeName'] ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          // Map Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 320,
                child: FlutterMap(
                  options: MapOptions(
                    center: points.isNotEmpty ? points[0] : LatLng(0, 0),
                    zoom: 13,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
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
                                  (_) => const Icon(
                                    Icons.location_on,
                                    color: Color(0xFF43A047),
                                    size: 36,
                                  ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Timings List Section
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: ListView.separated(
                    itemCount: timings.length,
                    separatorBuilder: (_, __) => const Divider(height: 24),
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              stopNames[index],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              timings[index].toString(),
                              style: const TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2E7D32),
                              ),
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
