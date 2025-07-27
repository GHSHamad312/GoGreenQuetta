import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class BusProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _buses = [];
  bool _isLoading = true;

  List<Map<String, dynamic>> get buses => _buses;
  bool get isLoading => _isLoading;

  BusProvider() {
    fetchBuses();
  }

  Future<void> fetchBuses() async {
    _isLoading = true;
    notifyListeners();
    final connectivity = await Connectivity().checkConnectivity();
    final box = await Hive.openBox('busesBox');
    if (connectivity == ConnectivityResult.none) {
      // Offline: load from cache
      final cached = box.get('buses');
      if (cached != null) {
        _buses = List<Map<String, dynamic>>.from(
          (cached as List).map((e) => Map<String, dynamic>.from(e)),
        );
      }
    } else {
      // Online: fetch from Firestore and cache
      try {
        final snapshot = await _firestore.collection('buses').get();
        _buses = snapshot.docs.map((doc) => doc.data()).toList();
        await box.put('buses', _buses);
      } catch (e) {
        print("Error fetching buses: $e");
        // fallback to cache if available
        final cached = box.get('buses');
        if (cached != null) {
          _buses = List<Map<String, dynamic>>.from(
            (cached as List).map((e) => Map<String, dynamic>.from(e)),
          );
        }
      }
    }
    _isLoading = false;
    notifyListeners();
  }
}
