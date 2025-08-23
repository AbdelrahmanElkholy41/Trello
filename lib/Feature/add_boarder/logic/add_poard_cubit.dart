import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
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

      final response = await supabase.from('boards').insert({
        'name': titleController.text, // أخدنا القيمة من الكنترولر
        'created_at': DateTime.now().toIso8601String(),
      }).select();

      if (response.isEmpty) {
        emit(AddPoardFailure("فشل إضافة البورد"));
      } else {
        emit(AddPoardSuccess("تم إضافة البورد: ${titleController.text}"));
        print(response);
        titleController.clear(); // نفرغ بعد الإضافة
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
