import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trello/core/helpers/spacing.dart';
import 'package:trello/core/theming/colors.dart';
import 'package:trello/core/widgets/coutom_text_field.dart';
import 'package:trello/core/widgets/custom_main_button.dart';

import '../../core/theming/styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              'Welcome To Trello',
              style: TextStyles.font18WhiteMedium,
            ),
          ),
          verticalSpace(50.h),
          CustomTextField(
            hintText: 'Email',
            validator: (value) {},
            backgroundColor: ColorsManager.trelloColor,
          ),
          verticalSpace(40.h),
          CustomTextField(
            hintText: 'Password',
            validator: (value) {},
            backgroundColor: ColorsManager.trelloColor,
          ),
          verticalSpace(80.h),
          AppTextButton(
            buttonText: 'Login',
            textStyle: TextStyles.font16WhiteMedium,
            onPressed: () {},
          ),
          verticalSpace(50.h),
          Center(
            child: RichText(
              text: TextSpan(
                text: 'Don\'t have an account?',
                style: TextStyles.font16WhiteMedium,
                children: [
                  TextSpan(
                    text: ' Sign Up',
                    style: TextStyles.font18WhiteMedium.copyWith(
                      color: Colors.blue, // خليها بلون مميز
                      decoration: TextDecoration.underline, // خط تحتها يبين انها لينك
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {

                      },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
