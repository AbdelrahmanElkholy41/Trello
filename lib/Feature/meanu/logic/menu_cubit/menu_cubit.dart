import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'menu_cubit.dart';
import 'menu_state.dart';

class BoardMembersCubit extends Cubit<BoardMembersState> {
  BoardMembersCubit() : super(BoardMembersInitial());

  final supabase = Supabase.instance.client;

  Future<void> getBoardMembers(int boardId) async {
    emit(BoardMembersLoading());
    try {
      // 1- هات الـ owner
      final boardResponse = await supabase
          .from('boards')
          .select('created_by')
          .eq('id', boardId)
          .single();

      final ownerId = boardResponse['created_by'];

      // 2- هات المدعوين
      final invitations = await supabase
          .from('invitations')
          .select('email, invited_by, accepted')
          .eq('board_id', boardId);

      // 3- اعمل ليست فيها الكل
      final members = [
        {"email": ownerId, "role": "owner", "accepted": true},
        ...invitations.map((e) => {
          "email": e['email'],
          "role": "member",
          "accepted": e['accepted'],
        }),
      ];

      emit(BoardMembersSuccess(members));
    } catch (e, s) {
      if (kDebugMode) {
        print("Error in getBoardMembers: $e");
      }
      if (kDebugMode) {
        print(s);
      }
      emit(BoardMembersError(e.toString()));
    }
  }
}
