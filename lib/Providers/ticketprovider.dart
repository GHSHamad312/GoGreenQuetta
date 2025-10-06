// ticket_provider.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TicketProvider with ChangeNotifier {
  Future<List<Map<String, dynamic>>> fetchUserTransactions(
    String userId,
  ) async {
    try {
      // Try a few common field names in case older documents used a different key
      final possibleFields = ['userId', 'uid', 'user_id', 'user'];
      final Map<String, Map<String, dynamic>> resultsById = {};

      for (final field in possibleFields) {
        try {
          QuerySnapshot qs;
          try {
            qs =
                await _firestore
                    .collection('transactions')
                    .where(field, isEqualTo: userId)
                    .orderBy('dateTime', descending: true)
                    .get();
          } catch (_) {
            qs =
                await _firestore
                    .collection('transactions')
                    .where(field, isEqualTo: userId)
                    .get();
          }

          for (final doc in qs.docs) {
            final raw = doc.data() as Map<String, dynamic>?;
            final Map<String, dynamic> data =
                raw != null
                    ? Map<String, dynamic>.from(raw)
                    : <String, dynamic>{};
            dynamic dtField = data['dateTime'] ?? data['dateTimeString'];
            DateTime? dt;
            if (dtField is Timestamp) {
              dt = dtField.toDate();
            } else if (dtField is String) {
              try {
                dt = DateTime.parse(dtField);
              } catch (_) {
                dt = null;
              }
            }

            resultsById[doc.id] = {'id': doc.id, ...data, 'dateTime': dt};
          }
        } catch (_) {
          // ignore and try next field name
        }
      }

      // If none found, try a fallback: fetch any transaction where userId field exists and equals userId (best-effort)
      if (resultsById.isEmpty) {
        try {
          final qs =
              await _firestore
                  .collection('transactions')
                  .where('userId', isEqualTo: userId)
                  .get();
          for (final doc in qs.docs) {
            final raw = doc.data() as Map<String, dynamic>?;
            final Map<String, dynamic> data =
                raw != null
                    ? Map<String, dynamic>.from(raw)
                    : <String, dynamic>{};
            dynamic dtField = data['dateTime'] ?? data['dateTimeString'];
            DateTime? dt;
            if (dtField is Timestamp) {
              dt = dtField.toDate();
            } else if (dtField is String) {
              try {
                dt = DateTime.parse(dtField);
              } catch (_) {
                dt = null;
              }
            }

            resultsById[doc.id] = {'id': doc.id, ...data, 'dateTime': dt};
          }
        } catch (_) {}
      }

      // Final fallback: fetch a small set of recent docs and filter client-side for uid matches
      if (resultsById.isEmpty) {
        try {
          QuerySnapshot recentQs;
          try {
            recentQs =
                await _firestore
                    .collection('transactions')
                    .orderBy('dateTime', descending: true)
                    .limit(100)
                    .get();
          } catch (_) {
            recentQs =
                await _firestore.collection('transactions').limit(100).get();
          }

          for (final doc in recentQs.docs) {
            final raw = doc.data() as Map<String, dynamic>?;
            final Map<String, dynamic> data =
                raw != null
                    ? Map<String, dynamic>.from(raw)
                    : <String, dynamic>{};

            // check values for direct uid match
            bool matched = false;
            for (final v in data.values) {
              if (v == userId) {
                matched = true;
                break;
              }
              if (v is String && v.contains(userId)) {
                matched = true;
                break;
              }
              if (v is Map) {
                if (v.values.any(
                  (sv) => sv == userId || (sv is String && sv.contains(userId)),
                )) {
                  matched = true;
                  break;
                }
              }
            }

            if (matched) {
              dynamic dtField = data['dateTime'] ?? data['dateTimeString'];
              DateTime? dt;
              if (dtField is Timestamp) {
                dt = dtField.toDate();
              } else if (dtField is String) {
                try {
                  dt = DateTime.parse(dtField);
                } catch (_) {
                  dt = null;
                }
              }

              resultsById[doc.id] = {'id': doc.id, ...data, 'dateTime': dt};
            }
          }
        } catch (_) {}
      }

      final list = resultsById.values.toList();
      list.sort((a, b) {
        final DateTime? da = a['dateTime'];
        final DateTime? db = b['dateTime'];
        if (da == null && db == null) return 0;
        if (da == null) return 1;
        if (db == null) return -1;
        return db.compareTo(da);
      });

      return List<Map<String, dynamic>>.from(list);
    } catch (e) {
      print("Error fetching transactions: $e");
      return [];
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> storeTransaction({
    required String busNumber,
    required String routeName,
    required DateTime dateTime,
    required int amount,
    required String userId,
  }) async {
    try {
      await _firestore.collection('transactions').add({
        'busNumber': busNumber,
        'routeName': routeName,
        // store as Timestamp for reliable ordering/queries and keep a string for legacy
        'dateTime': Timestamp.fromDate(dateTime),
        'dateTimeString': dateTime.toIso8601String(),
        'amount': amount,
        'userId': userId,
      });
    } catch (e) {
      print("Error storing transaction: $e");
    }
  }
}
