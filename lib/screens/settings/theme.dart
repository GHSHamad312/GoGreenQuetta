import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:greenbus_frontend/components/waveclipper.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  bool _isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Wave Header (matching ChangePasswordScreen)
          Stack(
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 180,
                  color: const Color.fromARGB(255, 102, 187, 106),
                ),
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
                      "Theme Settings",
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

          // Theme Toggle
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SwitchListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                title: Text(
                  "Dark Mode",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                secondary: Icon(
                  _isDarkTheme ? FontAwesomeIcons.moon : FontAwesomeIcons.sun,
                  color: const Color.fromARGB(255, 0, 121, 107),
                ),
                value: _isDarkTheme,
                onChanged: (val) {
                  setState(() {
                    _isDarkTheme = val;
                  });
                },
                activeColor: Colors.green,
                inactiveTrackColor: Colors.grey[300],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
