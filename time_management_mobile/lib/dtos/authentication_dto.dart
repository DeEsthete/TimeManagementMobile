import 'dart:convert';

class AuthenticationDto {
  final String username;
  final String password;

  AuthenticationDto({
    this.username,
    this.password,
  });

  AuthenticationDto copyWith({
    String username,
    String password,
  }) {
    return AuthenticationDto(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  static AuthenticationDto fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AuthenticationDto(
      username: map['username'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  static AuthenticationDto fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() =>
      'AuthenticationDto(username: $username, password: $password)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AuthenticationDto &&
        o.username == username &&
        o.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
