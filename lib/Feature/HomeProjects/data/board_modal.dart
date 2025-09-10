class Board {
  final int id;
  final DateTime createdAt;
  final String name;
  final String createdBy;

  Board({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.createdBy,
  });

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      id: json['id'] as int,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),

      name: json['name'] ?? "Untitled",
      createdBy: json['created_by'] ?? "Unknown",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'name': name,
      'created_by': createdBy,
    };
  }
}
