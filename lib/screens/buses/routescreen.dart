import 'package:greenbus_frontend/Providers/routeprovider.dart';
import 'package:greenbus_frontend/screens/buses/routeinfo.dart';
import 'package:flutter/material.dart';

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
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border(
              left: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 6,
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 90,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(0.08),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.directions_bus_filled,
                    size: 36,
                    color: Theme.of(context).colorScheme.primary,
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
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.confirmation_num,
                            size: 16,
                            color: Theme.of(
                              context,
                            ).iconTheme.color?.withOpacity(0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Bus: ${route['busNumber']}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color?.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 16,
                            color: Theme.of(
                              context,
                            ).iconTheme.color?.withOpacity(0.5),
                          ),
                          const SizedBox(width: 4),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.chevron_right,
                  size: 30,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
