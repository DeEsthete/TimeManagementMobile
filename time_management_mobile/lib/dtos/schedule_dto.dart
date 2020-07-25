import 'dart:convert';

class ScheduleDto {
  final int id;
  final DateTime dateCreate;
  final DateTime dateUpdate;
  final String scheduleDate;

  ScheduleDto({
    this.id,
    this.dateCreate,
    this.dateUpdate,
    this.scheduleDate,
  });

  ScheduleDto copyWith({
    int id,
    DateTime dateCreate,
    DateTime dateUpdate,
    String scheduleDate,
  }) {
    return ScheduleDto(
      id: id ?? this.id,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate ?? this.dateUpdate,
      scheduleDate: scheduleDate ?? this.scheduleDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateCreate': dateCreate,
      'dateUpdate': dateUpdate,
      'scheduleDate': scheduleDate,
    };
  }

  static ScheduleDto fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ScheduleDto(
      id: map['id']?.toInt(),
      dateCreate: map['dateCreate'],
      dateUpdate: map['dateUpdate'],
      scheduleDate: map['scheduleDate'],
    );
  }

  String toJson() => json.encode(toMap());

  static ScheduleDto fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'ScheduleDto(id: $id, dateCreate: $dateCreate, dateUpdate: $dateUpdate, scheduleDate: $scheduleDate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ScheduleDto &&
        o.id == id &&
        o.dateCreate == dateCreate &&
        o.dateUpdate == dateUpdate &&
        o.scheduleDate == scheduleDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dateCreate.hashCode ^
        dateUpdate.hashCode ^
        scheduleDate.hashCode;
  }
}
