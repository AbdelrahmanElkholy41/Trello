import 'package:PlanMate/core/helpers/spacing.dart';
import 'package:PlanMate/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theming/styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  String getInitials(String fullName) {
    final names = fullName.trim().split(' ');
    if (names.length == 1) return names[0][0].toUpperCase();
    return '${names[0][0]}${names[1][0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final initials = getInitials(
      'sddsdd sd',
    );

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            verticalSpace(30.h),
            CircleAvatar(
              radius: 50,
              child: Text(
                initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorsManager.trelloColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text('Log out',style: TextStyles.font16WhiteMedium,)),
            ),
            verticalSpace(15.h),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorsManager.trelloColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text('Delete account',style: TextStyles.font16WhiteMedium,)),
            ),
            verticalSpace(15.h)
          ],
        ),
      ),
    );
  }
}
