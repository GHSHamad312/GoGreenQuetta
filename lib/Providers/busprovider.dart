import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    try {
      final snapshot = await _firestore.collection('buses').get();
      _buses = snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching buses: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
