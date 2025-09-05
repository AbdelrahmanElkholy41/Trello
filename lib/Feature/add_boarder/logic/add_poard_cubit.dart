// Feature/add_boarder/logic/add_poard_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'add_poard_state.dart';

class AddPoardCubit extends Cubit<AddPoardState> {
  AddPoardCubit() : super(AddPoardInitial());

  final supabase = Supabase.instance.client;

  /// هنا ضيفنا الكنترولر
  final TextEditingController titleController = TextEditingController();

  Future<void> addBoard() async {
  try {
    emit(AddPoardLoading());

    final currentUser = supabase.auth.currentUser;

    if (currentUser == null) {
      emit(AddPoardFailure('don\'t have user logged in'));
      return;
    }

    final boardName = titleController.text.trim();
    if (boardName.isEmpty) {
      emit(AddPoardFailure('Board name cannot be empty'));
      return;
    }

    final response = await supabase
        .from('boards')
        .insert({
          'name': boardName,
          'created_by': currentUser.id,
        })
        .select()
        .single();

    emit(AddPoardSuccess("Board Added: $boardName"));
    print("Board Added: $response");
    titleController.clear();

  } catch (e) {
    emit(AddPoardFailure("Error: $e"));
  }
}



  @override
  Future<void> close() {
    titleController.dispose(); // مهم عشان ما يحصلش memory leak
    return super.close();
  }
}
