import 'dart:convert';

class BadResponseDto {
  final int statusCode;
  final String message;

  BadResponseDto({
    this.statusCode,
    this.message,
  });

  BadResponseDto copyWith({
    int statusCode,
    String message,
  }) {
    return BadResponseDto(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode,
      'message': message,
    };
  }

  static BadResponseDto fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return BadResponseDto(
      statusCode: map['statusCode'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  static BadResponseDto fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'BadResponseDto(statusCode: $statusCode, message: $message)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BadResponseDto &&
        o.statusCode == statusCode &&
        o.message == message;
  }

  @override
  int get hashCode => statusCode.hashCode ^ message.hashCode;
}
