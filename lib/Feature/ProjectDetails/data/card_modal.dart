class CardModel {
  final int id;
  final DateTime createdAt;
  final String title;
  final String description;
  final String assignedTo;
  final String status;
  final int position;
  final DateTime updatedAt;
  final int listId;

  CardModel({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.description,
    required this.assignedTo,
    required this.status,
    required this.position,
    required this.updatedAt,
    required this.listId,
  });

  /// fromJson (لما تجيب الداتا من Supabase/Postgres)
  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at']),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      assignedTo: json['assigned_to'] ?? '',
      status: json['status'] ?? '',
      position: json['position'] as int,
      updatedAt: DateTime.parse(json['updated_at']),
      listId: json['list_id'] as int,
    );
  }

  /// toJson (لما تبعت داتا لـ Supabase/Postgres)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'title': title,
      'description': description,
      'assigned_to': assignedTo,
      'status': status,
      'position': position,
      'updated_at': updatedAt.toIso8601String(),
      'list_id': listId,
    };
  }
}
