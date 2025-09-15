import 'package:PlanMate/Feature/Auth/logic/login_cubit.dart';
import 'package:PlanMate/core/helpers/extensions.dart';
import 'package:PlanMate/core/helpers/spacing.dart';
import 'package:PlanMate/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/routing/routes.dart';
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
    final String  name = Supabase.instance.client.auth.currentUser?.userMetadata?['name'] ?? "un"; // ✅ default value
    final initials = getInitials(name);
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is LoginInitial) {
            context.pushNamed(Routes.loginScreen);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                    GestureDetector(
                      onTap: (){
                        //context.read<LoginCubit>().logout();
                      },
                      child: Container(

                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: ColorsManager.trelloColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                              'Log out', style: TextStyles.font16WhiteMedium),
                        ),
                      ),
                    ),
                    verticalSpace(15.h),
                    GestureDetector(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: ColorsManager.trelloColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Delete account',
                            style: TextStyles.font16WhiteMedium,
                          ),
                        ),
                      ),
                    ),
                    verticalSpace(15.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
