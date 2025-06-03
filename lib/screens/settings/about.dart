import 'package:flutter/material.dart';
import 'package:greenbus_frontend/components/waveclipper.dart';

class AboutScreen extends StatelessWidget {
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
                      "About App",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.shade200.withOpacity(0.4),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(24),
                    child: Icon(
                      Icons.directions_bus_filled,
                      size: 100,
                      color: Colors.green.shade400,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Green Bus",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Version 1.0.0",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Green Bus is your smart transport companion designed to make your daily commute easier and greener. Track buses in real-time, purchase tickets seamlessly, and enjoy a smarter way to travel.",
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.5,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 40),
                  Text(
                    "© 2025 Green Bus Inc.",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
