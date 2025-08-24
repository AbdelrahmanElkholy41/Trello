import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trello/core/theming/colors.dart';

import '../../core/helpers/spacing.dart';
import '../../core/theming/styles.dart';
import '../../core/widgets/coutom_text_field.dart';
import '../../core/widgets/custom_main_button.dart';
import 'logic/add_poard_cubit.dart';

class AddBoarderScreen extends StatelessWidget {
  const AddBoarderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 8),
        child: BlocConsumer<AddPoardCubit, AddPoardState>(
          listener: (context, state) {
            if (state is AddPoardSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Navigator.pop(context, true); // ✅ هرجع بـ true
            } else if (state is AddPoardFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            } else if (state is AddPoardLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Loading...')),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<AddPoardCubit>();
            return AppTextButton(
              buttonText: 'Create Board',
              textStyle: TextStyles.font18DarkBlueBold,
              onPressed: () {
                cubit.addBoard();
              },
            );
          },
        ),
      ),
      appBar: AppBar(title: const Text('Create Board')),
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
                return null;
              },
              controller: context.read<AddPoardCubit>().titleController,
              backgroundColor: ColorsManager.trelloColor,
            ),
          ),
        ],
      ),
    );
  }
}
