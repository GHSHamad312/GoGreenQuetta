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
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => RouteDetailScreen(route: route)),
          );
        },
        child: Container(
          height: 100,
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(25, 0, 0, 0),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color.fromARGB(35, 67, 160, 72),
                child: Icon(
                  Icons.directions_bus,
                  color: Colors.green.shade700,
                  size: 28,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      route['busNumber'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: const Color.fromARGB(255, 46, 125, 50),
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      route['routeName'],
                      style: TextStyle(
                        color: const Color.fromARGB(255, 97, 97, 97),
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: const Color.fromARGB(255, 56, 142, 60),
              ),
            ],
          ),
        ),
      );
    },
  );
}
