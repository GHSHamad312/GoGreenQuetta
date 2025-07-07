import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greenbus_frontend/Providers/userdataprovider.dart';
import 'package:greenbus_frontend/screens/app/navmain.dart';
import 'package:greenbus_frontend/screens/auth/Loginscreen.dart';
import 'package:provider/provider.dart';

class Authverify extends StatelessWidget {
  const Authverify({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userprovider = Provider.of<UserDataProvider>(context);
          userprovider.getdata();
          return HomeMain();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
