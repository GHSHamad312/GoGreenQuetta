import 'package:flutter/material.dart';
import 'package:greenbus_frontend/Providers/routeprovider.dart';
import 'package:greenbus_frontend/screens/buses/routeinfo.dart';

Widget buildRoutes(RouteProvider provider) {
  if (provider.isLoading) {
    return const Center(child: CircularProgressIndicator());
  }

  return ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: provider.routes.length,
    itemBuilder: (context, index) {
      final route = provider.routes[index];

      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => RouteDetailScreen(route: route)),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
            border: Border(
              left: BorderSide(color: Colors.green.shade600, width: 6),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 90,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(40, 76, 175, 80),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.directions_bus_filled,
                    size: 36,
                    color: Colors.green.shade700,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        route['routeName'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.confirmation_num,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Bus: ${route['busNumber']}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: const [
                          Icon(Icons.schedule, size: 16, color: Colors.grey),
                          SizedBox(width: 4),
                          Text(
                            "Every 15 mins", // Example static info
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.chevron_right,
                  size: 30,
                  color: Color(0xFF388E3C),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
