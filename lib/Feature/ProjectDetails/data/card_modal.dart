class CardModel {
  final int id;
  final DateTime createdAt;
  final String title;
  final int listId;
  final String status;

  CardModel({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.listId,
    required this.status,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at']),
      title: json['title'] ?? '',
      listId: json['list_id'] as int,
      status: json['status'] ?? 'to do',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'title': title,
      'list_id': listId,
      'status': status,
    };
  }

  CardModel copyWith({
    int? id,
    DateTime? createdAt,
    String? title,
    int? listId,
    String? status,
  }) {
    return CardModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      listId: listId ?? this.listId,
      status: status ?? this.status,
    );
  }
}
