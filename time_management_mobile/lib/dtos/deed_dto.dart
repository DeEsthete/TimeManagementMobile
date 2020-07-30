import 'dart:convert';

class DeedDto {
  final int id;
  final DateTime dateCreate;
  final DateTime dateUpdate;
  final int userId;
  final String name;
  final bool isArchived;

  DeedDto({
    this.id,
    this.dateCreate,
    this.dateUpdate,
    this.userId,
    this.name,
    this.isArchived,
  });

  DeedDto copyWith({
    int id,
    DateTime dateCreate,
    DateTime dateUpdate,
    int userId,
    String name,
    bool isArchived,
  }) {
    return DeedDto(
      id: id ?? this.id,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate ?? this.dateUpdate,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      isArchived: isArchived ?? this.isArchived,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateCreate': dateCreate?.toIso8601String(),
      'dateUpdate': dateUpdate?.toIso8601String(),
      'userId': userId,
      'name': name,
      'isArchived': isArchived,
    };
  }

  static DeedDto fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DeedDto(
      id: map['id'],
      dateCreate: DateTime.tryParse(map['dateCreate']),
      dateUpdate: DateTime.tryParse(map['dateUpdate']),
      userId: map['userId'],
      name: map['name'],
      isArchived: map['isArchived'],
    );
  }

  String toJson() => json.encode(toMap());

  static DeedDto fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'DeedDto(id: $id, dateCreate: $dateCreate, dateUpdate: $dateUpdate, userId: $userId, name: $name, isArchived: $isArchived)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DeedDto &&
        o.id == id &&
        o.dateCreate == dateCreate &&
        o.dateUpdate == dateUpdate &&
        o.userId == userId &&
        o.name == name &&
        o.isArchived == isArchived;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dateCreate.hashCode ^
        dateUpdate.hashCode ^
        userId.hashCode ^
        name.hashCode ^
        isArchived.hashCode;
  }
}
