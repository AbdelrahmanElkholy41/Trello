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
        // ✅ احفظ التوكن
        final prefs = await SharedPreferences.getInstance();
        final session = response.session;
        if (session != null) {
          await prefs.setString('token', session.accessToken);
          print("✅ Token saved: ${session.accessToken}");
        }

        emit(LoginSuccess(user.id));
      } else {
        emit(LoginFailure("فشل تسجيل الدخول. تأكد من البيانات."));
      }
    } on AuthException catch (e) {
      emit(LoginFailure("خطأ في تسجيل الدخول: ${e.message}"));
    } catch (e) {
      emit(LoginFailure("Unexpected error: $e"));
    }
  }


  Future<void> signUp() async {
    emit(LoginLoading());
    try {
      if (passwordController.text.trim() != confirmpasswordController.text.trim()) {
        emit(LoginFailure("كلمة المرور غير متطابقة"));
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
        emit(LoginFailure("فشل إنشاء الحساب. حاول مرة أخرى."));
      }
    } on AuthException catch (e) {
      emit(LoginFailure("خطأ في إنشاء الحساب: ${e.message}"));
    } catch (e) {
      emit(LoginFailure("Unexpected error: $e"));
    }
  }


  Future<void> logout() async {
    try {
      await supabase.auth.signOut();
      emit(LoginInitial());
    } catch (e) {
      emit(LoginFailure("فشل تسجيل الخروج: $e"));
    }
  }
}
