import 'package:flutter/material.dart';

import '../../../core/helpers/spacing.dart';

class UserAvatar extends StatelessWidget {
  final String userName;
  final double radius;

  const UserAvatar({
    Key? key,
    required this.userName,
    this.radius = 32,
  }) : super(key: key);

  /// 🔡 Get initials from full name (e.g. "Ahmed Khaled" → "AK")
  String getInitials(String fullName) {
    final names = fullName.trim().split(' ');
    if (names.length == 1) return names[0][0].toUpperCase();
    return '${names[0][0]}${names[1][0]}'.toUpperCase();
  }

  /// 🎨 Generate consistent color based on name hash
  Color getColorFromName(String name) {
    final hash = name.hashCode;
    final r = (hash & 0xFF0000) >> 16;
    final g = (hash & 0x00FF00) >> 8;
    final b = (hash & 0x0000FF);
    return Color.fromARGB(255, r, g, b);
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: getColorFromName(userName),
      child: Text(
        getInitials(userName),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: radius * 0.6,
        ),
      ),

    );
  }
}
