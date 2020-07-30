import 'dart:convert';

class UserDto {
  final int id;
  final DateTime dateCreate;
  final DateTime dateUpdate;
  final String nickname;
  final String userName;
  final String role;

  UserDto({
    this.id,
    this.dateCreate,
    this.dateUpdate,
    this.nickname,
    this.userName,
    this.role,
  });

  UserDto copyWith({
    int id,
    DateTime dateCreate,
    DateTime dateUpdate,
    String nickname,
    String userName,
    String role,
  }) {
    return UserDto(
      id: id ?? this.id,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate ?? this.dateUpdate,
      nickname: nickname ?? this.nickname,
      userName: userName ?? this.userName,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateCreate': dateCreate?.toIso8601String(),
      'dateUpdate': dateUpdate?.toIso8601String(),
      'nickname': nickname,
      'userName': userName,
      'role': role,
    };
  }

  static UserDto fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserDto(
      id: map['id'],
      dateCreate: DateTime.tryParse(map['dateCreate']),
      dateUpdate: DateTime.tryParse(map['dateUpdate']),
      nickname: map['nickname'],
      userName: map['userName'],
      role: map['role'],
    );
  }

  String toJson() => json.encode(toMap());

  static UserDto fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserDto(id: $id, dateCreate: $dateCreate, dateUpdate: $dateUpdate, nickname: $nickname, userName: $userName, role: $role)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserDto &&
        o.id == id &&
        o.dateCreate == dateCreate &&
        o.dateUpdate == dateUpdate &&
        o.nickname == nickname &&
        o.userName == userName &&
        o.role == role;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dateCreate.hashCode ^
        dateUpdate.hashCode ^
        nickname.hashCode ^
        userName.hashCode ^
        role.hashCode;
  }
}
