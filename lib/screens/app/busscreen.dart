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

  final List<String> tabs = ["Routes", "Capacity", "Nearest"];
  final List<IconData> tabIcons = [
    Icons.alt_route,
    Icons.event_seat,
    Icons.location_searching,
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RouteProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF43A047), Color(0xFF66BB6A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.directions_bus, color: Colors.white),
              SizedBox(width: 8),
              Text(
                "Buses",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: List.generate(tabs.length, (index) {
                  final selected = _selectedIndex == index;
                  return Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color:
                            selected
                                ? const Color(0xFF388E3C)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 4,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                tabIcons[index],
                                color:
                                    selected
                                        ? Colors.white
                                        : Colors.grey.shade700,
                                size: 20,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                tabs[index],
                                style: TextStyle(
                                  color:
                                      selected
                                          ? Colors.white
                                          : Colors.grey.shade700,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _getSelectedTabContent(provider),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSelectedTabContent(RouteProvider provider) {
    switch (_selectedIndex) {
      case 0:
        return buildRoutes(provider);
      case 1:
        return const CapacityPage();
      case 2:
        return NearestBusWidget();
      default:
        return const SizedBox.shrink();
    }
  }
}
