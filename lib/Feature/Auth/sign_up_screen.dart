import 'package:PlanMate/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helpers/spacing.dart';
import '../../core/routing/routes.dart';
import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
import '../../core/widgets/coutom_text_field.dart';
import '../../core/widgets/custom_main_button.dart';
import 'logic/login_cubit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
  listener: (context, state) {
    if(state is LoginSuccess){
      context.pushNamed(Routes.homeScreen);
    }else if(state is LoginFailure){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
    }
    else if(state is LoginLoading){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Loading')));
    }
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [

              Text('Welcome To Trello , Sign Up ',style: TextStyles.font18WhiteMedium,),
              verticalSpace(50.h),
              Text('Name',style: TextStyles.font16WhiteMedium,),
              verticalSpace(10.h),
              CustomTextField(
                controller: context.read<LoginCubit>().nameController,
                hintText: 'Please Enter Your Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                },
                backgroundColor: ColorsManager.trelloColor,
                textStyle: TextStyles.font16WhiteMedium,
              ),
              verticalSpace(20.h),
              Text('Email',style: TextStyles.font16WhiteMedium,),
              verticalSpace(10.h),
              CustomTextField(
                controller: context.read<LoginCubit>().emailController,
                hintText: 'Please Enter Your Email',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                },
                backgroundColor: ColorsManager.trelloColor,
                textStyle: TextStyles.font16WhiteMedium,
              ),
              verticalSpace(20.h),
              Text('Password',style: TextStyles.font16WhiteMedium,),
              verticalSpace(10.h),
              CustomTextField(
                controller: context.read<LoginCubit>().passwordController,
                hintText: 'Create Password',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                },
                backgroundColor: ColorsManager.trelloColor,
                textStyle: TextStyles.font16WhiteMedium,
              ),
              verticalSpace(20.h),
              Text('Confirm Password',style: TextStyles.font16WhiteMedium,),
              verticalSpace(10.h),
              CustomTextField(
                controller: context.read<LoginCubit>().confirmpasswordController,
                hintText: 'Confirm Password',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                },
                backgroundColor: ColorsManager.trelloColor,
              textStyle: TextStyles.font16WhiteMedium,
              ),
              verticalSpace(50.h),
              AppTextButton(
                buttonText: 'Sign up',
                textStyle: TextStyles.font18WhiteMedium,
                onPressed: () {
                  context.read<LoginCubit>().signUp();
                },
              ),
            ],
          ),
        ),
      ),
    );
  },
);
  }
}
