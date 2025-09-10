import '../data/list_modal.dart';

abstract class ListState {}

class ListInitial extends ListState {}

class ListLoading extends ListState {}

class ListLoaded extends ListState {
  final List<ListModel> lists;
  ListLoaded(this.lists);
}

class ListError extends ListState {
  final String message;
  ListError(this.message);
}
