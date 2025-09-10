class CardModel {
  final int id;
  final DateTime createdAt;
  final String title;
  final int listId;

  CardModel({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.listId,
  });

  /// fromJson (لما تجيب الداتا من Supabase/Postgres)
  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at']),
      title: json['title'] ?? '',
      listId: json['list_id'] as int,
    );
  }

  /// toJson (لما تبعت داتا لـ Supabase/Postgres)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'title': title,
      'list_id': listId,
    };
  }
}
