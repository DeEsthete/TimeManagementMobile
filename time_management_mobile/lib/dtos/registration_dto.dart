import 'dart:convert';

class RegistrationDto {
  final String nickname;
  final String userName;
  final String password;

  RegistrationDto({
    this.nickname,
    this.userName,
    this.password,
  });

  RegistrationDto copyWith({
    String nickname,
    String userName,
    String password,
  }) {
    return RegistrationDto(
      nickname: nickname ?? this.nickname,
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'userName': userName,
      'password': password,
    };
  }

  static RegistrationDto fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RegistrationDto(
      nickname: map['nickname'],
      userName: map['userName'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  static RegistrationDto fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() =>
      'RegistrationDto(nickname: $nickname, userName: $userName, password: $password)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RegistrationDto &&
        o.nickname == nickname &&
        o.userName == userName &&
        o.password == password;
  }

  @override
  int get hashCode => nickname.hashCode ^ userName.hashCode ^ password.hashCode;
}
