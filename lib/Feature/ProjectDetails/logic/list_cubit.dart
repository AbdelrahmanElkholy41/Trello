import 'package:bloc/bloc.dart';
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


  Future<int?> addList(int boardId, String title) async {
    try {
      final response = await supabase.from('lists').insert({
        'board_id': boardId,
        'title': title,
      }).select(); // ✅ نرجع البيانات اللي اتضافت

      if (response != null && response.isNotEmpty) {
        final listId = response.first['id'] as int; // ✅ ناخد ID الليست
        getLists(boardId); // نجيب الليستات بعد الإضافة
        return listId;
      }
    } catch (e) {
      emit(ListError(e.toString()));
    }
    return null; // لو حصل Error
  }
}
