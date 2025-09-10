class InvitationModel {
  final int? id;
  final String email;
  final int? boardId;
  final String? invitedBy;
  final bool? accepted;

  InvitationModel({
    this.id,
    required this.email,
    this.boardId,
    this.invitedBy,
    this.accepted,
  });

  factory InvitationModel.fromMap(Map<String, dynamic> map) {
    return InvitationModel(
      id: map['id'],
      email: map['email'],
      boardId: map['board_id'],
      invitedBy: map['invited_by'],
      accepted: map['accepted'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'board_id': boardId,
      'invited_by': invitedBy,
      'accepted': accepted,
    };
  }
}
