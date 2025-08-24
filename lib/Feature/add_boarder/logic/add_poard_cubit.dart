import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../HomeProjects/logic/board_cubit.dart';

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
        emit(AddPoardFailure('do not have user'));
        return;
      }

      final response = await supabase.from('boards').insert({
        'name': titleController.text, // من الكنترولر
        'created_at': DateTime.now().toIso8601String(),
        'created_by': currentUser.id, // 👈 هنا الإضافة المهمة
      }).select();

      if (response.isEmpty) {
        emit(AddPoardFailure("فشل إضافة البورد"));
      } else {
        emit(AddPoardSuccess("تم إضافة البورد: ${titleController.text}"));
        print("Board Added: $response");
        titleController.clear();
      }
    } catch (e) {
      emit(AddPoardFailure("خطأ: $e"));
    }
  }


  @override
  Future<void> close() {
    titleController.dispose(); // مهم عشان ما يحصلش memory leak
    return super.close();
  }
}
