import 'dart:convert';

class DeedPeriodsCountDto {
  final int deedId;
  final int periodsCount;

  DeedPeriodsCountDto({
    this.deedId,
    this.periodsCount,
  });

  DeedPeriodsCountDto copyWith({
    int deedId,
    int periodsCount,
  }) {
    return DeedPeriodsCountDto(
      deedId: deedId ?? this.deedId,
      periodsCount: periodsCount ?? this.periodsCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'deedId': deedId,
      'periodsCount': periodsCount,
    };
  }

  static DeedPeriodsCountDto fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DeedPeriodsCountDto(
      deedId: map['deedId']?.toInt(),
      periodsCount: map['periodsCount']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  static DeedPeriodsCountDto fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() =>
      'DeedPeriodsCountDto(deedId: $deedId, periodsCount: $periodsCount)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DeedPeriodsCountDto &&
        o.deedId == deedId &&
        o.periodsCount == periodsCount;
  }

  @override
  int get hashCode => deedId.hashCode ^ periodsCount.hashCode;
}
