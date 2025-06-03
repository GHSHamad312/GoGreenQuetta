import 'package:flutter/material.dart';
import 'package:greenbus_frontend/Providers/busprovider.dart';
import 'package:greenbus_frontend/screens/buses/visualcap.dart';
import 'package:provider/provider.dart';

class CapacityPage extends StatelessWidget {
  const CapacityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BusProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.buses.length,
          itemBuilder: (context, index) {
            final bus = provider.buses[index];

            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BusCapacityDetail(
                          busNumber: bus['busnumber'],
                          currentCapacity: bus['currentCapacity'],
                          totalCapacity: bus['capacity'],
                        ),
                  ),
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
                        Icons.directions_bus_filled,
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
                            bus['busnumber'] ?? 'Unknown Bus',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromARGB(255, 46, 125, 50),
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Capacity: ${bus['currentCapacity'] ?? 0} / ${bus['capacity'] ?? 0}",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 97, 97, 97),
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
      },
    );
  }
}
