import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:greenbus_frontend/Providers/authprovider.dart';
import 'package:greenbus_frontend/Providers/busprovider.dart';
import 'package:greenbus_frontend/Providers/navigationprovider.dart';
import 'package:greenbus_frontend/Providers/routeprovider.dart';
import 'package:greenbus_frontend/Providers/ticketprovider.dart';
import 'package:greenbus_frontend/Providers/userdataprovider.dart';
import 'package:greenbus_frontend/screens/auth/authverify.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Authprovider()),
        ChangeNotifierProvider(create: (_) => UserDataProvider()..getdata()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => RouteProvider()..fetchRoutes()),
        ChangeNotifierProvider(create: (_) => BusProvider()),
        ChangeNotifierProvider(create: (_) => TicketProvider()),
      ],
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
