import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:greenbus_frontend/Providers/routeprovider.dart';
import 'package:greenbus_frontend/Providers/userdataprovider.dart';
import 'package:greenbus_frontend/components/homecard.dart';
import 'package:greenbus_frontend/screens/app/busscreen.dart';
import 'package:greenbus_frontend/screens/app/notis.dart';
import 'package:greenbus_frontend/screens/app/ticketbuyscreen.dart';
import 'package:greenbus_frontend/screens/buses/nearestscreen.dart';
import 'package:greenbus_frontend/screens/buses/routescreen.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = Provider.of<RouteProvider>(context);
    final userName = Provider.of<UserDataProvider>(context).userdata['name'];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: 20,
                          color: const Color.fromARGB(255, 75, 75, 75),
                        ),
                      ),
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 46, 125, 50),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationPage(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      radius: 22,
                      child: Icon(
                        Icons.notifications,
                        color: const Color.fromARGB(255, 46, 125, 50),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BusScreen()),
                      );
                    },
                    child: quickButton(
                      icon: FontAwesomeIcons.bus,
                      label: "Track Bus",
                      color: const Color.fromARGB(255, 56, 142, 60),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TicketBuyScreen(),
                        ),
                      );
                    },
                    child: quickButton(
                      icon: FontAwesomeIcons.ticket,
                      label: "Buy Ticket",
                      color: const Color.fromARGB(255, 251, 140, 0),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NearestBusWidget(),
                        ),
                      );
                    },
                    child: quickButton(
                      icon: FontAwesomeIcons.locationDot,
                      label: "Nearest Bus",
                      color: const Color.fromARGB(255, 30, 136, 229),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "What's New",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 27, 94, 32),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 56, 142, 60),
                    const Color.fromARGB(255, 142, 151, 255),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "New eco-friendly buses launched on Route 5! ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(Icons.eco, color: Colors.white, size: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
