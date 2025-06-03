import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class RouteProvider extends ChangeNotifier {
  List<Map<String, dynamic>> routes = [];

  bool isLoading = false;

  Future<void> fetchRoutes() async {
    isLoading = true;
    notifyListeners();

    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('routes').get();
      routes =
          snapshot.docs.map((doc) {
            final data = doc.data();
            return {
              'id': doc.id,
              'busNumber': data['busNumber'] ?? '',
              'routeName': data['routeName'] ?? '',
              'capacity': data['capacity'] ?? 0,
              'currentCapacity': data['currentCapacity'] ?? 0,
              'timings': List<String>.from(data['timings'] ?? []),
              'stops':
                  (data['stops'] as List).map((stop) {
                    return {
                      'name': stop['name'],
                      'latlng': LatLng(stop['lat'], stop['lng']),
                    };
                  }).toList(),
            };
          }).toList();
    } catch (e) {
      print("Error fetching routes: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Map<String, dynamic>? getRouteById(String id) {
    return routes.firstWhere((route) => route['id'] == id, orElse: () => {});
  }
}
