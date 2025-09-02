import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trello/core/helpers/spacing.dart';
import 'package:trello/core/theming/colors.dart';
import 'package:trello/core/widgets/coutom_text_field.dart';
import 'package:trello/core/widgets/custom_main_button.dart';

import '../../core/theming/styles.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [

            Text('Welcome To Trello , Sign Up ',style: TextStyles.font18WhiteMedium,),
            verticalSpace(50.h),
            CustomTextField(
              hintText: 'Name',
              validator: (value) {},
              backgroundColor: ColorsManager.trelloColor,
              textStyle: TextStyles.font16WhiteMedium,
            ),
            verticalSpace(30.h),
            CustomTextField(
              hintText: 'Email',
              validator: (value) {},
              backgroundColor: ColorsManager.trelloColor,
              textStyle: TextStyles.font16WhiteMedium,
            ),
            verticalSpace(30.h),
            CustomTextField(
              hintText: 'Password',
              validator: (value) {},
              backgroundColor: ColorsManager.trelloColor,
              textStyle: TextStyles.font16WhiteMedium,
            ),
            verticalSpace(30.h),
            CustomTextField(
              hintText: 'Confirm Password',
              validator: (value) {},
              backgroundColor: ColorsManager.trelloColor,),
            verticalSpace(80.h),
            AppTextButton(
              buttonText: 'Sign up',
              textStyle: TextStyles.font18WhiteMedium,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
