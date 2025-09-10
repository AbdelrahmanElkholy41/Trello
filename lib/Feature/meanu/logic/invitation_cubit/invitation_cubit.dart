import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'invitation_state.dart';

class InvitationCubit extends Cubit<InvitationState> {
  InvitationCubit() : super(InvitationInitial());

  final client = Supabase.instance.client;

  /// مفتاح Resend API (بدّله باللي خدته من موقع Resend)
  static const String resendApiKey = "re_K7WbWwDb_FimXwuKXk8cG7fNKv2vpmYcj";

  /// إرسال دعوة لشخص ما للانضمام إلى Board
  Future<void> sendInvitation(String email, int boardId, {String? invitedBy}) async {
    emit(InvitationLoading());

    try {
      // تسجيل الدعوة في جدول invitations مع token يتولد تلقائي
      final insertResponse = await client.from('invitations').insert({
        'email': email,
        'board_id': boardId,
        'invited_by': invitedBy,
        'accepted': true,

      }).select().single();

      final token = insertResponse['token']; // نجيب الـ token من الـ DB

      // محتوى الإيميل
      final subject = "دعوة للانضمام إلى المشروع";
      final html = """
        <h2>أهلاً بك 👋</h2>
        <p>لقد تمت دعوتك للانضمام إلى المشروع.</p>
        <p>اضغط على الرابط للانضمام:</p>
        <a href="https://your-app.com/invitation?email=$email&board_id=$boardId&token=$token">
          قبول الدعوة
        </a>
      """;

      // إرسال الإيميل عبر Resend API
      final response = await http.post(
        Uri.parse("https://api.resend.com/emails"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $resendApiKey",
        },
        body: jsonEncode({
          "from": "onboarding@resend.dev", // لازم يكون Verified
          "to": email,
          "subject": subject,
          "html": html,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        emit(InvitationSuccess());
      } else {
        emit(InvitationError(message: "Email sending failed: ${response.body}"));
      }
    } catch (e) {
      emit(InvitationError(message: e.toString()));
    }
  }
}
