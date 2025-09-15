import 'package:PlanMate/core/helpers/extensions.dart';
import 'package:flutter/gestures.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   bool _isPasswordObscure=true;
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
        return WillPopScope(
          onWillPop: ()async{
            return true;
          },
          child: Scaffold(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      backgroundColor: ColorsManager.trelloColor,
                    ),
                    verticalSpace(40.h),
                    CustomTextField(
                      textStyle: TextStyles.font16WhiteMedium,
                      controller: context.read<LoginCubit>().passwordController,
                      hintText: 'Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      backgroundColor: ColorsManager.trelloColor,
                      isObscureText: _isPasswordObscure,

                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPasswordObscure = !_isPasswordObscure;
                          });
                        },
                        child: Icon(
                          _isPasswordObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility,
                          color: ColorsManager.mainBlue,
                        ),
                      ),
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
          ),
        );
      },
    );
  }
}
