import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final supabase = Supabase.instance.client;

  Future<void> login() async {
    emit(LoginLoading());
    try {
      final response = await supabase.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final user = response.user;

      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        final session = response.session;
        if (session != null) {
          await prefs.setString('token', session.accessToken);
          print("✅ Token saved: ${session.accessToken}");
        }

        emit(LoginSuccess(user.id));
        emailController.clear();
        passwordController.clear();
      } else {
        emit(LoginFailure('do not have user'));
      }
    } on AuthException catch (e) {
      emit(LoginFailure("failed to login: ${e.message}"));
    } catch (e) {
      emit(LoginFailure("Unexpected error: $e"));
    }
  }


  Future<void> signUp() async {
    emit(LoginLoading());
    try {
      if (passwordController.text.trim() != confirmpasswordController.text.trim()) {
        emit(LoginFailure("passwords don't match"));
        return;
      }

      final response = await supabase.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        data: {
          'name': nameController.text.trim(),
        },
      );

      final user = response.user;
      if (user != null) {
        emit(LoginSuccess(user.id));
      } else {
        emit(LoginFailure("failed to create user"));
      }
    } on AuthException catch (e) {
      emit(LoginFailure("failed to sign up: ${e.message}"));
    } catch (e) {
      emit(LoginFailure("Unexpected error: $e"));
    }
  }


  Future<void> logout() async {
    try {
      await supabase.auth.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');

      emit(LoginInitial());
    } catch (e) {
      emit(LoginFailure("failed to logout: $e"));
    }
  }
}
