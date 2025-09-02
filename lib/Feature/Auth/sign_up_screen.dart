import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trello/core/helpers/spacing.dart';
import 'package:trello/core/widgets/coutom_text_field.dart';
import 'package:trello/core/widgets/custom_main_button.dart';

import '../../core/theming/styles.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Column(
        children: [
          verticalSpace(30.h),
          CustomTextField(hintText: 'Email', validator: (value) {}),
          verticalSpace(30.h),
          CustomTextField(hintText: 'Password', validator: (value) {}),
          verticalSpace(80.h),
          AppTextButton(
            buttonText: 'Sign up',
            textStyle: TextStyles.font18WhiteMedium,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
