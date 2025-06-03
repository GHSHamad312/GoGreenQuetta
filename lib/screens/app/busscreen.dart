import 'package:flutter/material.dart';
import 'package:greenbus_frontend/Providers/routeprovider.dart';
import 'package:greenbus_frontend/screens/buses/capacityscreen.dart';
import 'package:greenbus_frontend/screens/buses/nearestscreen.dart';
import 'package:greenbus_frontend/screens/buses/routescreen.dart';
import 'package:provider/provider.dart';

class BusScreen extends StatefulWidget {
  @override
  _BusScreenState createState() => _BusScreenState();
}

class _BusScreenState extends State<BusScreen> {
  int _selectedIndex = 0;
  final tabs = ["Routes", "Capacity", "Nearest Bus"];

  @override
  void initState() {
    super.initState();
    Provider.of<RouteProvider>(context, listen: false).fetchRoutes();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RouteProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 249, 249),
      appBar: AppBar(
        title: const Text("Buses"),
        backgroundColor: const Color.fromARGB(255, 143, 255, 148),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                tabs.length,
                (index) => Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color:
                            _selectedIndex == index
                                ? const Color.fromARGB(255, 56, 142, 60)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          tabs[index],
                          style: TextStyle(
                            color:
                                _selectedIndex == index
                                    ? Colors.white
                                    : const Color.fromARGB(255, 97, 97, 97),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: _getSelectedTabContent(provider)),
        ],
      ),
    );
  }

  Widget _getSelectedTabContent(RouteProvider provider) {
    switch (_selectedIndex) {
      case 0:
        return buildRoutes(provider);
      case 1:
        return CapacityPage();
      case 2:
        return NearestBusWidget();
      default:
        return const SizedBox.shrink();
    }
  }
}
