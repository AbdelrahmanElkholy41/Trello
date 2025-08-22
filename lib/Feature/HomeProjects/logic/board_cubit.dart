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
      final response = await supabase.from('boards').select();

      print("Response: $response");

      if (response.isEmpty) {
        emit(BoardSuccess([])); // مفيش Boards
        return;
      }

      final boards = (response as List<dynamic>)
          .map((b) => Board.fromJson(b as Map<String, dynamic>))
          .toList();

      emit(BoardSuccess(boards));
    } catch (e, s) {
      print("Error: $e");
      print(s);
      emit(BoardError(e.toString()));
    }
  }
}
