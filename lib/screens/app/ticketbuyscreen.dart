import 'package:flutter/material.dart';
import 'package:greenbus_frontend/Providers/busprovider.dart';
import 'package:greenbus_frontend/Providers/routeprovider.dart';
import 'package:greenbus_frontend/screens/tickets/ticketsummar.dart';
import 'package:provider/provider.dart';

class TicketBuyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final busProvider = Provider.of<BusProvider>(context);
    final routeProvider = Provider.of<RouteProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Buy Ticket'),
        backgroundColor: Colors.green.shade600,
      ),
      body:
          busProvider.isLoading || routeProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: routeProvider.routes.length,
                itemBuilder: (context, index) {
                  final route = routeProvider.routes[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TicketSummaryScreen(route: route),
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
                            backgroundColor: const Color.fromARGB(
                              35,
                              67,
                              160,
                              72,
                            ),
                            child: Icon(
                              Icons.confirmation_num,
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
                                  route['routeName'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 46, 125, 50),
                                  ),
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Bus: ${route['busNumber']}',
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
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => TicketSummaryScreen(route: route),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                67,
                                160,
                                71,
                              ),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Select'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
