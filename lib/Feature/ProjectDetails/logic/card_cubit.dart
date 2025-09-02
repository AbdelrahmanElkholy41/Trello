import 'package:bloc/bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/card_modal.dart';
import 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit() : super(CardInitial());

  final supabase = Supabase.instance.client;

  /// get all cards for a specific list
  Future<void> getCards(int listId) async {
    emit(CardLoading());
    try {
      final response = await supabase
          .from('cards')
          .select()
          .eq('list_id', listId)
          .order('position', ascending: true);

      final cards = (response as List)
          .map((e) => CardModel.fromJson(e as Map<String, dynamic>))
          .toList();

      emit(CardLoaded(cards));
    } catch (e) {
      emit(CardError(e.toString()));
    }
  }

  /// add new card
  Future<void> addCard({
    required int listId,
    required String title,
    required String description,
    required String assignedTo,
    required String status,
    required int position,
  }) async {
    try {
      await supabase.from('cards').insert({
        'list_id': listId,
        'title': title,
        'description': description,
        'assigned_to': assignedTo,
        'status': status,
        'position': position,
        'updated_at': DateTime.now().toIso8601String(),
      });

      /// refresh cards
      getCards(listId);
    } catch (e) {
      emit(CardError(e.toString()));
    }
  }

  /// update card
  Future<void> updateCard(CardModel card) async {
    try {
      await supabase.from('cards').update({
        'title': card.title,
        'description': card.description,
        'assigned_to': card.assignedTo,
        'status': card.status,
        'position': card.position,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', card.id);

      getCards(card.listId);
    } catch (e) {
      emit(CardError(e.toString()));
    }
  }

  /// delete card
  Future<void> deleteCard(int cardId, int listId) async {
    try {
      await supabase.from('cards').delete().eq('id', cardId);
      getCards(listId);
    } catch (e) {
      emit(CardError(e.toString()));
    }
  }
}
