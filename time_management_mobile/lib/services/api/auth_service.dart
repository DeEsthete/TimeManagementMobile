import 'dart:convert';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:time_management_mobile/constant/route_consts.dart';
import 'package:time_management_mobile/dtos/authentication_dto.dart';
import 'package:time_management_mobile/dtos/token_dto.dart';
import 'package:time_management_mobile/services/app/http_service.dart';

@injectable
class AuthService {
  final _root = Routes.root + 'users/';
  Client _client = HttpService();

  Future<TokenDto> authenticate(AuthenticationDto authenticationDto) async {
    var result = await _client.post(
      _root + 'authenticate',
      body: authenticationDto.toJson(),
    );
    return TokenDto.fromJson(result.body);
  }

  void dispose() {
    if (_client != null) {
      _client.close();
    }
  }
}
