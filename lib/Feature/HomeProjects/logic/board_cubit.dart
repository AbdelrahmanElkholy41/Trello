// Feature/HomeProjects/logic/board_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/board_modal.dart';
import 'board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  BoardCubit() : super(BoardInitial());

  final supabase = Supabase.instance.client;

  Future<void> getBoards() async {
    emit(BoardLoading());
    try {
      final currentUser = supabase.auth.currentUser;

      if (currentUser == null) {
        emit(BoardError("do not any user"));
        return;
      }

      final email = currentUser.email;
      if (email == null) {
        emit(BoardError("email do not exist"));
        return;
      }


      final response = await supabase
          .from('boards')
          .select()
          .eq('created_by', currentUser.id);

      List<Board> boards = (response as List<dynamic>)
          .map((b) => Board.fromJson(b as Map<String, dynamic>))
          .toList();


      final invitations = await supabase
          .from('invitations')
          .select('board_id')
          .eq('email', email)
          .eq('accepted', true);

      final invitedBoardIds =
      (invitations as List).map((e) => e['board_id'] as int).toList();

      if (invitedBoardIds.isNotEmpty) {
        final invitedBoards = await supabase
            .from('boards')
            .select()
            .inFilter('id', invitedBoardIds);

        boards.addAll(
          (invitedBoards as List<dynamic>)
              .map((b) => Board.fromJson(b as Map<String, dynamic>))
              .toList(),
        );
      }

      emit(BoardSuccess(boards));
    } catch (e, s) {
      print("Error: $e");
      print(s);
      emit(BoardError(e.toString()));
    }
  }
}
