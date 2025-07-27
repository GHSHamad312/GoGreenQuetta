import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:greenbus_frontend/screens/tickets/ticketconfirm.dart';

class TicketSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> route;

  const TicketSummaryScreen({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    const int price = 100;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Ticket Summary'),
        backgroundColor: Colors.green.shade700,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _ticketCard(theme),
            const Spacer(),
            _paymentSummary(theme, price),
            const SizedBox(height: 20),
            _confirmButton(context, price),
          ],
        ),
      ),
    );
  }

  Widget _ticketCard(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ticket Details',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildInfoRow(Icons.route, 'Route', route['routeName']),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.directions_bus, 'Bus Number', route['busNumber']),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.schedule, 'Timings', route['timings'].join(', ')),
        ],
      ),
    );
  }

  Widget _paymentSummary(ThemeData theme, int price) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Price',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.green.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Rs. $price',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _confirmButton(BuildContext context, int price) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _handleConfirm(context, price),
        icon: const Icon(Icons.lock),
        label: const Text(
          'Confirm & Pay Securely',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade700,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24, color: Colors.green.shade600),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _handleConfirm(BuildContext context, int price) async {
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
