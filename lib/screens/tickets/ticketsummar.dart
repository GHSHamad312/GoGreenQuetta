import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greenbus_frontend/screens/tickets/ticketconfirm.dart';

class TicketSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> route;

  const TicketSummaryScreen({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    const int price = 100;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Ticket Summary'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ticketCard(context),
            Spacer(),
            paymentSummary(context, price),
            SizedBox(height: 20),
            confirmButton(context, price),
          ],
        ),
      ),
    );
  }

  Widget ticketCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ticket Details',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          buildInfoRow(Icons.route, 'Route', route['routeName'], context),
          const SizedBox(height: 16),
          buildInfoRow(
            Icons.directions_bus,
            'Bus Number',
            route['busNumber'],
            context,
          ),
          SizedBox(height: 16),
          buildInfoRow(
            Icons.schedule,
            'Timings',
            route['timings'].join(', '),
            context,
          ),
        ],
      ),
    );
  }

  Widget paymentSummary(BuildContext context, int price) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Price',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Rs. $price',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget confirmButton(BuildContext context, int price) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => handleConfirm(context, price),
        icon: const Icon(Icons.lock),
        label: const Text(
          'Confirm & Pay Securely',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(
    IconData icon,
    String title,
    String value,
    BuildContext context,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).hintColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> handleConfirm(BuildContext context, int price) async {
    try {
      final firestore = FirebaseFirestore.instance;

      final query =
          await firestore
              .collection('buses')
              .where('busnumber', isEqualTo: route['busNumber'])
              .limit(1)
              .get();

      if (query.docs.isNotEmpty) {
        final doc = query.docs.first;
        final currentCapacity = doc['currentCapacity'] ?? 0;
        final totalCapacity = doc['capacity'] ?? 0;

        if (currentCapacity < totalCapacity) {
          await firestore.collection('buses').doc(doc.id).update({
            'currentCapacity': currentCapacity + 1,
          });

          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => TicketConfirmationScreen(route: route, amount: price),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sorry, no seats available.'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bus not found.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
