import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BusProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _buses = [];
  bool _isLoading = true;
  late final Stream<QuerySnapshot<Map<String, dynamic>>> _busStream;

  List<Map<String, dynamic>> get buses => _buses;
  bool get isLoading => _isLoading;

  BusProvider() {
    _busStream = _firestore.collection('buses').snapshots();
    _listenToBusStream();
  }

  void _listenToBusStream() {
    _busStream.listen(
      (snapshot) {
        _buses = snapshot.docs.map((doc) => doc.data()).toList();
        _isLoading = false;
        notifyListeners();
      },
      onError: (e) {
        print("Error listening to bus stream: $e");
      },
    );
  }
}
