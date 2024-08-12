import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class AppBarIcons extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;
  final VoidCallback? onTap;

  const AppBarIcons({
    required this.icon,
    this.backgroundColor = const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF756d54),
    this.size = 40,
    this.iconSize = 16,
    this.onTap, // Add an onTap callback
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Handle the tap event
      borderRadius: BorderRadius.circular(size / 2), // Ensure ripple effect matches the container shape
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: backgroundColor,
        ),
        child: Center(
          child: Icon(
            icon,
            color: iconColor,
            size: iconSize // Adjust icon size relative to the container size
          ),
        ),
      ),
    );
  }
}
