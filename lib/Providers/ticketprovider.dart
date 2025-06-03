// ticket_provider.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TicketProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> storeTransaction({
    required String busNumber,
    required String routeName,
    required DateTime dateTime,
    required int amount,
  }) async {
    try {
      await _firestore.collection('transactions').add({
        'busNumber': busNumber,
        'routeName': routeName,
        'dateTime': dateTime.toIso8601String(),
        'amount': amount,
      });
    } catch (e) {
      print("Error storing transaction: $e");
    }
  }
}
