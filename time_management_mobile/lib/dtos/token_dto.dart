import 'dart:convert';

class TokenDto {
  final String accessToken;
  final String userName;

  TokenDto({
    this.accessToken,
    this.userName,
  });

  TokenDto copyWith({
    String accessToken,
    String userName,
  }) {
    return TokenDto(
      accessToken: accessToken ?? this.accessToken,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'userName': userName,
    };
  }

  static TokenDto fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TokenDto(
      accessToken: map['accessToken'],
      userName: map['userName'],
    );
  }

  String toJson() => json.encode(toMap());

  static TokenDto fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'TokenDto(accessToken: $accessToken, userName: $userName)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TokenDto &&
        o.accessToken == accessToken &&
        o.userName == userName;
  }

  @override
  int get hashCode => accessToken.hashCode ^ userName.hashCode;
}
