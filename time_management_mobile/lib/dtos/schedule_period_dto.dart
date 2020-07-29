import 'dart:convert';

class SchedulePeriodDto {
  final int id;
  final DateTime dateCreate;
  final DateTime dateUpdate;
  final int scheduleId;
  final int deedId;
  final DateTime startDate;
  final DateTime endDate;
  final String description;

  SchedulePeriodDto({
    this.id,
    this.dateCreate,
    this.dateUpdate,
    this.scheduleId,
    this.deedId,
    this.startDate,
    this.endDate,
    this.description,
  });

  SchedulePeriodDto copyWith({
    int id,
    DateTime dateCreate,
    DateTime dateUpdate,
    int scheduleId,
    int deedId,
    DateTime startDate,
    DateTime endDate,
    String description,
  }) {
    return SchedulePeriodDto(
      id: id ?? this.id,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate ?? this.dateUpdate,
      scheduleId: scheduleId ?? this.scheduleId,
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
      'scheduleId': scheduleId,
      'deedId': deedId,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
      'description': description,
    };
  }

  static SchedulePeriodDto fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SchedulePeriodDto(
      id: map['id'],
      dateCreate: DateTime.tryParse(map['dateCreate']),
      dateUpdate: DateTime.tryParse(map['dateUpdate']),
      scheduleId: map['scheduleId'],
      deedId: map['deedId'],
      startDate: DateTime.tryParse(map['startDate']),
      endDate: DateTime.tryParse(map['endDate']),
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  static SchedulePeriodDto fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'SchedulePeriodDto(id: $id, dateCreate: $dateCreate, dateUpdate: $dateUpdate, scheduleId: $scheduleId, deedId: $deedId, startDate: $startDate, endDate: $endDate, description: $description)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SchedulePeriodDto &&
        o.id == id &&
        o.dateCreate == dateCreate &&
        o.dateUpdate == dateUpdate &&
        o.scheduleId == scheduleId &&
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
        scheduleId.hashCode ^
        deedId.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        description.hashCode;
  }
}
