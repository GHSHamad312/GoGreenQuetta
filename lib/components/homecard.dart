import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

Widget quickButton({
  required IconData icon,
  required String label,
  required Color color,
}) {
  return Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(icon, color: Colors.white, size: 28),
        SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
