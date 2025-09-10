
import '../data/board_modal.dart';



abstract class BoardState {}

class BoardInitial extends BoardState {}

class BoardLoading extends BoardState {}

class BoardSuccess extends BoardState {
  final List<Board> boards;
  BoardSuccess(this.boards);
}

class BoardError extends BoardState {
  final String message;
  BoardError(this.message);
}
