import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

Widget quickButton({
  required IconData icon,
  required String label,
  required Color color,
}) {
  return Builder(
    builder:
        (context) => Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                icon,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 28,
              ),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
  );
}
