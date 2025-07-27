import 'package:flutter/material.dart';
import 'package:greenbus_frontend/Providers/ticketprovider.dart';
import 'package:provider/provider.dart';

class TicketConfirmationScreen extends StatefulWidget {
  final Map<String, dynamic> route;
  final int amount;

  const TicketConfirmationScreen({
    required this.route,
    required this.amount,
    super.key,
  });

  @override
  State<TicketConfirmationScreen> createState() =>
      _TicketConfirmationScreenState();
}

class _TicketConfirmationScreenState extends State<TicketConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _storeTransaction();
  }

  Future<void> _storeTransaction() async {
    final ticketProvider = Provider.of<TicketProvider>(context, listen: false);

    await ticketProvider.storeTransaction(
      busNumber: widget.route['busNumber'],
      routeName: widget.route['routeName'],
      dateTime: DateTime.now(),
      amount: widget.amount,
    );

    setState(() {
      _isCompleted = true;
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child:
              _isCompleted
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedScale(
                        scale: _scaleAnimation.value,
                        duration: const Duration(milliseconds: 500),
                        child: Icon(
                          Icons.check_circle_rounded,
                          size: 110,
                          color: Colors.green.shade600,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Payment Successful!',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Your ticket has been booked.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        icon: const Icon(Icons.home_outlined),
                        label: const Text('Back to Home'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                      ),
                    ],
                  )
                  : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
