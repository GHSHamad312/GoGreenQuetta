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

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorScheme.primary, colorScheme.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
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
            children: [
              Icon(Icons.directions_bus, color: colorScheme.onPrimary),
              const SizedBox(width: 8),
              Text(
                "Buses",
                style: theme.textTheme.titleLarge?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
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
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withOpacity(0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
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
                            selected ? colorScheme.primary : Colors.transparent,
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
                                        ? colorScheme.onPrimary
                                        : colorScheme.onSurface,
                                size: 20,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                tabs[index],
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color:
                                      selected
                                          ? colorScheme.onPrimary
                                          : colorScheme.onSurface,
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
