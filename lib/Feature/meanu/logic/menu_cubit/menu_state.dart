
abstract class BoardMembersState  {
  const BoardMembersState();

  @override
  List<Object?> get props => [];
}

class BoardMembersInitial extends BoardMembersState {}

class BoardMembersLoading extends BoardMembersState {}

class BoardMembersSuccess extends BoardMembersState {
  final List<Map<String, dynamic>> members;
  const BoardMembersSuccess(this.members);

  @override
  List<Object?> get props => [members];
}

class BoardMembersError extends BoardMembersState {
  final String message;
  const BoardMembersError(this.message);

  @override
  List<Object?> get props => [message];
}
