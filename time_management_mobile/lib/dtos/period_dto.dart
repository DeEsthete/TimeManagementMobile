import 'dart:convert';

class PeriodDto {
  final int id;
  final DateTime dateCreate;
  final DateTime dateUpdate;
  final int deedId;
  final DateTime startDate;
  final DateTime endDate;
  final String description;

  PeriodDto({
    this.id,
    this.dateCreate,
    this.dateUpdate,
    this.deedId,
    this.startDate,
    this.endDate,
    this.description,
  });

  PeriodDto copyWith({
    int id,
    DateTime dateCreate,
    DateTime dateUpdate,
    int deedId,
    DateTime startDate,
    DateTime endDate,
    String description,
  }) {
    return PeriodDto(
      id: id ?? this.id,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate ?? this.dateUpdate,
      deedId: deedId ?? this.deedId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateCreate': dateCreate?.millisecondsSinceEpoch,
      'dateUpdate': dateUpdate?.millisecondsSinceEpoch,
      'deedId': deedId,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
      'description': description,
    };
  }

  static PeriodDto fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PeriodDto(
      id: map['id'],
      dateCreate: DateTime.tryParse(map['dateCreate']),
      dateUpdate: DateTime.tryParse(map['dateUpdate']),
      deedId: map['deedId'],
      startDate: DateTime.tryParse(map['startDate']),
      endDate: DateTime.tryParse(map['endDate']),
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  static PeriodDto fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'PeriodDto(id: $id, dateCreate: $dateCreate, dateUpdate: $dateUpdate, deedId: $deedId, startDate: $startDate, endDate: $endDate, description: $description)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PeriodDto &&
        o.id == id &&
        o.dateCreate == dateCreate &&
        o.dateUpdate == dateUpdate &&
        o.deedId == deedId &&
        o.startDate == startDate &&
        o.endDate == endDate &&
        o.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dateCreate.hashCode ^
        dateUpdate.hashCode ^
        deedId.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        description.hashCode;
  }
}
