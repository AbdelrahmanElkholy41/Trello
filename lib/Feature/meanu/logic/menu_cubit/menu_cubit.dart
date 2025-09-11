import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'menu_state.dart';

class BoardMembersCubit extends Cubit<BoardMembersState> {
  BoardMembersCubit() : super(BoardMembersInitial());

  final supabase = Supabase.instance.client;

  Future<void> getBoardMembers(int boardId) async {
    emit(BoardMembersLoading());

    try {
      // 1- جلب الـ owner id
      final boardResponse = await supabase
          .from('boards')
          .select('created_by')
          .eq('id', boardId)
          .single();

      final ownerId = boardResponse['created_by'];

      // 2- جلب اسم و ايميل الـ owner من الـ auth مباشرة
      final currentUser = supabase.auth.currentUser;
      final ownerName = currentUser?.userMetadata?['name'] ?? currentUser?.email ?? "Unknown";
      final ownerEmail = currentUser?.email ?? ownerId.toString();

      // 3- جلب المدعوين من جدول invitations
      final invitations = await supabase
          .from('invitations')
          .select('email, invited_by, accepted')
          .eq('board_id', boardId);

      // 4- جهز قائمة الأعضاء
      final members = [
        {
          "email": ownerEmail,
          "role": "owner",
          "accepted": true,
          "name": ownerName
        },
        ...await Future.wait(invitations.map((e) async {
          // حاول تجيب الاسم من جدول users
          final userResp = await supabase
              .from('users')
              .select('name')
              .eq('email', e['email'])
              .maybeSingle();

          final userName = userResp != null
              ? userResp['name'] ?? e['email']
              : e['email'];

          return {
            "email": e['email'],
            "role": "member",
            "accepted": e['accepted'],
            "name": userName,
          };
        }))
      ];

      emit(BoardMembersSuccess(members));
    } catch (e, s) {
      if (kDebugMode) {
        print("Error in getBoardMembers: $e");
        print(s);
      }
      emit(BoardMembersError(e.toString()));
    }
  }
}
