import 'dart:convert';

class PurposeDto {
  final String name;
  final int id;
  final DateTime dateCreate;
  final DateTime dateUpdate;
  final int purposeStatusId;
  final DateTime dateStart;
  final DateTime dateEnd;
  final int deedId;
  final int requiredHours;
  final int haveHours;

  PurposeDto({
    this.name,
    this.id,
    this.dateCreate,
    this.dateUpdate,
    this.purposeStatusId,
    this.dateStart,
    this.dateEnd,
    this.deedId,
    this.requiredHours,
    this.haveHours,
  });

  PurposeDto copyWith({
    String name,
    int id,
    DateTime dateCreate,
    DateTime dateUpdate,
    int purposeStatusId,
    DateTime dateStart,
    DateTime dateEnd,
    int deedId,
    int requiredHours,
    int haveHours,
  }) {
    return PurposeDto(
      name: name ?? this.name,
      id: id ?? this.id,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate ?? this.dateUpdate,
      purposeStatusId: purposeStatusId ?? this.purposeStatusId,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      deedId: deedId ?? this.deedId,
      requiredHours: requiredHours ?? this.requiredHours,
      haveHours: haveHours ?? this.haveHours,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'dateCreate': dateCreate?.toIso8601String(),
      'dateUpdate': dateUpdate?.toIso8601String(),
      'purposeStatusId': purposeStatusId,
      'dateStart': dateStart?.toIso8601String(),
      'dateEnd': dateEnd?.toIso8601String(),
      'deedId': deedId,
      'requiredHours': requiredHours,
      'haveHours': haveHours,
    };
  }

  static PurposeDto fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PurposeDto(
      name: map['name'],
      id: map['id'],
      dateCreate: DateTime.tryParse(map['dateCreate']),
      dateUpdate: DateTime.tryParse(map['dateUpdate']),
      purposeStatusId: map['purposeStatusId'],
      dateStart: DateTime.tryParse(map['dateStart']),
      dateEnd: DateTime.tryParse(map['dateEnd']),
      deedId: map['deedId'],
      requiredHours: map['requiredHours'],
      haveHours: map['haveHours'],
    );
  }

  String toJson() => json.encode(toMap());

  static PurposeDto fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'PurposeDto(name: $name, id: $id, dateCreate: $dateCreate, dateUpdate: $dateUpdate, purposeStatusId: $purposeStatusId, dateStart: $dateStart, dateEnd: $dateEnd, deedId: $deedId, requiredHours: $requiredHours, haveHours: $haveHours)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PurposeDto &&
        o.name == name &&
        o.id == id &&
        o.dateCreate == dateCreate &&
        o.dateUpdate == dateUpdate &&
        o.purposeStatusId == purposeStatusId &&
        o.dateStart == dateStart &&
        o.dateEnd == dateEnd &&
        o.deedId == deedId &&
        o.requiredHours == requiredHours &&
        o.haveHours == haveHours;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        dateCreate.hashCode ^
        dateUpdate.hashCode ^
        purposeStatusId.hashCode ^
        dateStart.hashCode ^
        dateEnd.hashCode ^
        deedId.hashCode ^
        requiredHours.hashCode ^
        haveHours.hashCode;
  }
}
