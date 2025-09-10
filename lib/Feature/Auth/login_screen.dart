import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trello/core/helpers/extensions.dart';
import 'package:trello/core/helpers/spacing.dart';
import 'package:trello/core/routing/routes.dart';
import 'package:trello/core/theming/colors.dart';
import 'package:trello/core/widgets/coutom_text_field.dart';
import 'package:trello/core/widgets/custom_main_button.dart';
import '../../core/theming/styles.dart';
import 'logic/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.pushNamed(Routes.homeScreen);
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is LoginLoading) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Loading')));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(automaticallyImplyLeading: false),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset('assets/logo2.png',width: 200,)),
                  verticalSpace(36.h),
                  CustomTextField(
                    textStyle: TextStyles.font18WhiteMedium,
                    controller: context.read<LoginCubit>().emailController,
                    hintText: 'Email',
                    validator: (value) {},
                    backgroundColor: ColorsManager.trelloColor,
                  ),
                  verticalSpace(40.h),
                  CustomTextField(
                    textStyle: TextStyles.font16WhiteMedium,
                    controller: context.read<LoginCubit>().passwordController,
                    hintText: 'Password',
                    validator: (value) {},
                    backgroundColor: ColorsManager.trelloColor,
                  ),
                  verticalSpace(80.h),
                  AppTextButton(
                    buttonText: 'Login',
                    textStyle: TextStyles.font16WhiteMedium,
                    onPressed: () {
                      context.read<LoginCubit>().login();
                    },
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
                              decoration: TextDecoration
                                  .underline,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              context.pushNamed(Routes.signUpScreen);
                            },
                          ),
                        ],
                      ),
                    ),
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
