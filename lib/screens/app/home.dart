import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:greenbus_frontend/Providers/userdataprovider.dart';
import 'package:greenbus_frontend/components/homecard.dart';
import 'package:greenbus_frontend/screens/app/busscreen.dart';
import 'package:greenbus_frontend/screens/app/notis.dart';
import 'package:greenbus_frontend/screens/app/ticketbuyscreen.dart';
import 'package:greenbus_frontend/screens/buses/nearestscreen.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Map<String, dynamic>> _userFuture;

  @override
  void initState() {
    super.initState();
    final userdata = Provider.of<UserDataProvider>(context, listen: false);
    _userFuture = userdata.getdata();
  }

  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<UserDataProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with welcome message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 75, 75, 75),
                        ),
                      ),
                      FutureBuilder<Map<String, dynamic>>(
                        future: _userFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            );
                          } else if (snapshot.hasData &&
                              snapshot.data?["name"] != null) {
                            return Text(
                              snapshot.data!['name'],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            );
                          } else {
                            return Text(
                              "Guest",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            );
                          }
                        },
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
                      backgroundColor: Theme.of(context).cardColor,
                      radius: 22,
                      child: Icon(
                        Icons.notifications,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Quick buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  quickNavButton(
                    "Track Bus",
                    FontAwesomeIcons.bus,
                    Theme.of(context).colorScheme.primary,
                    BusScreen(),
                  ),
                  quickNavButton(
                    "Buy Ticket",
                    FontAwesomeIcons.ticket,
                    Theme.of(context).colorScheme.secondary,
                    TicketBuyScreen(),
                  ),
                  quickNavButton(
                    "Nearest Bus",
                    FontAwesomeIcons.locationDot,
                    Theme.of(context).colorScheme.tertiary,
                    NearestBusWidget(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // What's New section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "What's New",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
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
                        "New eco-friendly buses launched on Route 5!",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.eco,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget quickNavButton(
    String label,
    IconData icon,
    Color color,
    Widget screen,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
      child: quickButton(icon: icon, label: label, color: color),
    );
  }
}
