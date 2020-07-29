import 'dart:convert';

class ReferenceEntityDto {
  final int id;
  final DateTime dateCreate;
  final DateTime dateUpdate;
  final String name;
  final String code;

  ReferenceEntityDto({
    this.id,
    this.dateCreate,
    this.dateUpdate,
    this.name,
    this.code,
  });

  ReferenceEntityDto copyWith({
    int id,
    DateTime dateCreate,
    DateTime dateUpdate,
    String name,
    String code,
  }) {
    return ReferenceEntityDto(
      id: id ?? this.id,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate ?? this.dateUpdate,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateCreate': dateCreate?.millisecondsSinceEpoch,
      'dateUpdate': dateUpdate?.millisecondsSinceEpoch,
      'name': name,
      'code': code,
    };
  }

  static ReferenceEntityDto fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ReferenceEntityDto(
      id: map['id'],
      dateCreate: DateTime.tryParse(map['dateCreate']),
      dateUpdate: DateTime.tryParse(map['dateUpdate']),
      name: map['name'],
      code: map['code'],
    );
  }

  String toJson() => json.encode(toMap());

  static ReferenceEntityDto fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReferenceEntityDto(id: $id, dateCreate: $dateCreate, dateUpdate: $dateUpdate, name: $name, code: $code)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ReferenceEntityDto &&
        o.id == id &&
        o.dateCreate == dateCreate &&
        o.dateUpdate == dateUpdate &&
        o.name == name &&
        o.code == code;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dateCreate.hashCode ^
        dateUpdate.hashCode ^
        name.hashCode ^
        code.hashCode;
  }
}
