import 'package:flutter/material.dart';
import 'package:greenbus_frontend/components/waveclipper.dart';

class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Container(height: 180, color: Colors.green.shade400),
              ),
              Positioned(
                top: 50,
                left: 20,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Help & Support",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                  leading: Icon(Icons.email, color: Colors.green.shade600),
                  title: Text(
                    "ghshamad314@gmail.com",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.phone, color: Colors.green.shade600),
                  title: Text("+92 3156038384", style: TextStyle(fontSize: 16)),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.question_answer,
                    color: Colors.green.shade600,
                  ),
                  title: Text(
                    "Frequently Asked Questions",
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey[600],
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
