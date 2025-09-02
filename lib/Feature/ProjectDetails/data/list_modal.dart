class ListModel {
  final int id;
  final int boardId;
  final String title;
  final DateTime createdAt;

  ListModel({
    required this.id,
    required this.boardId,
    required this.title,
    required this.createdAt,
  });

  factory ListModel.fromJson(Map<String, dynamic> json) {
    return ListModel(
      id: json['id'] as int,
      boardId: json['board_id'] as int,
      title: (json['name'] ?? '') as String, // حماية من null
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(), // default لو null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'board_id': boardId,
      'name': title,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'ListModel(id: $id, boardId: $boardId, title: $title, createdAt: $createdAt)';
  }
}
