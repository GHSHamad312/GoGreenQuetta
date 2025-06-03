import 'package:flutter/material.dart';
import 'package:greenbus_frontend/Providers/navigationprovider.dart';
import 'package:greenbus_frontend/screens/app/accountsettingscreen.dart';
import 'package:greenbus_frontend/screens/app/busscreen.dart';
import 'package:greenbus_frontend/screens/app/home.dart';
import 'package:greenbus_frontend/screens/app/ticketbuyscreen.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    final navprovider = Provider.of<NavigationProvider>(context);
    final pages = [Home(), BusScreen(), TicketBuyScreen(), AccountScreen()];

    return Scaffold(
      body: IndexedStack(index: navprovider.currentindex, children: pages),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        child: SalomonBottomBar(
          currentIndex: navprovider.currentindex,
          onTap: navprovider.setindex,
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              selectedColor: Colors.green,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.directions_bus_filled),
              title: Text("Buses"),
              selectedColor: Colors.green,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.attach_money),
              title: Text("Buy"),
              selectedColor: Colors.green,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.settings),
              title: Text("Settings"),
              selectedColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
