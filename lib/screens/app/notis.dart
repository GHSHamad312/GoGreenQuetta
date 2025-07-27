import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(child: Text("No new notifications right now.")),
    );
  }
}
