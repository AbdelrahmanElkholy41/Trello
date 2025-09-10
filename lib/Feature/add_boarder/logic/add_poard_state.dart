part of 'add_poard_cubit.dart';

@immutable
abstract class AddPoardState {}

class AddPoardInitial extends AddPoardState {}

class AddPoardLoading extends AddPoardState {}

class AddPoardSuccess extends AddPoardState {
  final String message;
  AddPoardSuccess(this.message);
}

class AddPoardFailure extends AddPoardState {
  final String error;
  AddPoardFailure(this.error);
}
