// ticket_confirmation_screen.dart
import 'package:flutter/material.dart';
import 'package:greenbus_frontend/Providers/ticketprovider.dart';
import 'package:provider/provider.dart';

class TicketConfirmationScreen extends StatelessWidget {
  final Map<String, dynamic> route;
  final int amount;

  const TicketConfirmationScreen({required this.route, required this.amount});

  @override
  Widget build(BuildContext context) {
    final ticketProvider = Provider.of<TicketProvider>(context, listen: false);

    return FutureBuilder(
      future: ticketProvider.storeTransaction(
        busNumber: route['busNumber'],
        routeName: route['routeName'],
        dateTime: DateTime.now(),
        amount: amount,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          backgroundColor: Colors.green.shade50,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 100,
                    color: Colors.green.shade600,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Payment Successful!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your ticket has been booked.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      backgroundColor: Colors.green.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed:
                        () => Navigator.popUntil(
                          context,
                          (route) => route.isFirst,
                        ),
                    child: Text('Back to Home', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
