import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../data/list_modal.dart';
import 'list_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ListCubit extends Cubit<ListState> {
  ListCubit() : super(ListInitial());

  final supabase = Supabase.instance.client;

  Future<void> getLists(int boardId) async {
    emit(ListLoading());
    try {
      final response = await supabase
          .from('lists')
          .select()
          .eq('board_id', boardId);
      print("Supabase response: $response"); // debug

      final lists = (response as List)
          .map((e) => ListModel.fromJson(e))
          .toList();
      print("Parsed lists: $lists"); // debug

      emit(ListLoaded(lists));
    } catch (e) {
      print("Error fetching lists: $e"); // debug
      emit(ListError(e.toString()));
    }
  }


  Future<int?> addList({required int boardId, required String name}) async {
    try {
      final response = await supabase.from('lists').insert({
        'board_id': boardId,
        'name': name,
        'position': 8
      }).select();

      if (response.isNotEmpty) {
        final listId = response.first['id'] as int;
        getLists(boardId); // refresh بعد الإضافة
        return listId;
      }
    } catch (e) {
      emit(ListError(e.toString()));
    }
    return null;
  }

}
