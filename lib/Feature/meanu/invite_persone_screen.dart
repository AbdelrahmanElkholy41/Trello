import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trello/core/helpers/spacing.dart';
import 'package:trello/core/theming/colors.dart';
import 'package:trello/core/widgets/coutom_text_field.dart';
import 'package:trello/core/widgets/custom_main_button.dart';

import '../../core/theming/styles.dart';

class InvitePersoneScreen extends StatelessWidget {
  const InvitePersoneScreen({super.key});

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 50),
        child: AppTextButton(buttonText: 'Invite', textStyle: TextStyles.font14DarkBlueBold, onPressed: (){}),
      ) ,
      appBar: AppBar(),
      body: Column(
        children: [
          verticalSpace(50.h),
          CustomTextField(
            hintText: 'Enter Email',
            validator: (value) {},
            backgroundColor: ColorsManager.trelloColor,
            textStyle: TextStyles.font16WhiteMedium,
          ),

        ],
      ),
    );
  }
}
