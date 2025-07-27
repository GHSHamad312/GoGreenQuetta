import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:greenbus_frontend/Providers/theme_provider.dart';
import 'package:greenbus_frontend/components/waveclipper.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
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
                      "Theme Settings",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

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
                  theme.isDark ? FontAwesomeIcons.moon : FontAwesomeIcons.sun,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                value: theme.isDark,
                onChanged: (val) {
                  theme.toggleTheme();
                },
                activeColor: Theme.of(context).colorScheme.primary,
                inactiveTrackColor:
                    Theme.of(context).colorScheme.surfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
