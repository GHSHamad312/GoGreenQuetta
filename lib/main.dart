import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:greenbus_frontend/Providers/authprovider.dart';
import 'package:greenbus_frontend/screens/auth/authverify.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Authprovider())],
      child: GoGreenQuetta(),
    ),
  );
}

class GoGreenQuetta extends StatelessWidget {
  const GoGreenQuetta({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "GoGreenQuetta", home: Authverify());
  }
}
