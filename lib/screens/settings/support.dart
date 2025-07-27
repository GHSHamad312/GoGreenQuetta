import 'package:flutter/material.dart';
import 'package:greenbus_frontend/components/waveclipper.dart';

class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 180,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Positioned(
                top: 50,
                left: 20,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Help & Support",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Support content
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              children: [
                ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    "ghshamad314@gmail.com",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text("+92 3156038384", style: TextStyle(fontSize: 16)),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.question_answer,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    "Frequently Asked Questions",
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Theme.of(context).hintColor,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
