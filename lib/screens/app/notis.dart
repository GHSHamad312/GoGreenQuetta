import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: const Color.fromARGB(255, 56, 142, 60),
      ),
      body: Center(child: Text("No new notifications right now.")),
    );
  }
}
