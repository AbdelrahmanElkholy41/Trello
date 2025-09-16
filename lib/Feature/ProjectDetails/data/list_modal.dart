class ListModel {
  final int id;
  final int boardId;
  final String name;
  final DateTime createdAt;
  final int position;


  ListModel( {
    required this.id,
    required this.boardId,
    required this.name,
    required this.createdAt, required  this.position,
  });

  factory ListModel.fromJson(Map<String, dynamic> json) {
    return ListModel(
      id: json['id'] as int,
      position: json['position'] as int,
      boardId: json['board_id'] as int,
      name: (json['name'] ?? '') as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'board_id': boardId,
      'name': name,
      'created_at': createdAt.toIso8601String(),
      'position': position,
    };
  }

  @override
  String toString() {
    return 'ListModel(id: $id, boardId: $boardId, title: $name, createdAt: $createdAt, position: $position)';
  }
}
