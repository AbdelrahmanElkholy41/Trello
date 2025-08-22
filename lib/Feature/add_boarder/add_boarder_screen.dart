import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trello/core/theming/colors.dart';

import '../../core/helpers/spacing.dart';
import '../../core/theming/styles.dart';
import '../../core/widgets/coutom_text_field.dart';
import '../../core/widgets/custom_main_button.dart';

class AddBoarderScreen extends StatelessWidget {
  const AddBoarderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical:50,horizontal: 8),
        child: AppTextButton(buttonText: 'Create Board',textStyle: TextStyles.font18DarkBlueBold, onPressed: () {  },),
      ),
      appBar: AppBar(title: Text('Create Boarder')),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          verticalSpace(50.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomTextField(
              textStyle: TextStyles.font18WhiteMedium,
              hintText: 'Enter Board Name',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Board Name';
                }
              },
              backgroundColor: ColorsManager.trelloColor
            ),
          ),

        ],
      ),
    );
  }
}
