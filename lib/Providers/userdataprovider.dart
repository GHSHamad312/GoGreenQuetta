import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class UserDataProvider with ChangeNotifier {
  Map<String, dynamic> userdata = {};
  bool datafetched = false;

  Future<void> savedata(String name, int phone) async {
    User user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.collection("Users").doc(user.uid).set({
      "email": user.email,
      "name": name,
      "phone": phone,
      "creationtime": FieldValue.serverTimestamp(),
    });
    notifyListeners();
  }

  Future<Map<String, dynamic>> getdata() async {
    User user = FirebaseAuth.instance.currentUser!;

    DocumentSnapshot doc =
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(user.uid)
            .get();

    if (doc.exists) {
      userdata = doc.data() as Map<String, dynamic>;
      datafetched = true;
      return userdata;
    } else {
      throw Exception("User data not found");
    }
  }
}
