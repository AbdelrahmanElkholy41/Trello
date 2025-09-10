part of 'invitation_cubit.dart';

@immutable
abstract class InvitationState {}

class InvitationInitial extends InvitationState {}

class InvitationLoading extends InvitationState {}

class InvitationSuccess extends InvitationState {}

class InvitationError extends InvitationState {
  final String message;
  InvitationError({required this.message});
}
