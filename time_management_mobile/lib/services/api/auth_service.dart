import 'dart:async';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:time_management_mobile/constant/filter_consts.dart';
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

    if (HttpResults.allowedHttpStatuses.contains(result.statusCode)) {
      return TokenDto.fromJson(result.body);
    }

    HttpService.badResponseSubject.add(result);
    return Future.error(result);
  }

  void dispose() {
    if (_client != null) {
      _client.close();
    }
  }

  // Future<TokenDto> authenticate(AuthenticationDto authenticationDto) async {
  //   var result = await _client.post(
  //     _root + 'authenticate',
  //     body: authenticationDto.toJson(),
  //   ).asStream().transform(StreamTransformer

  //   if (HttpResults.allowedHttpStatuses.contains(result.statusCode)) {
  //     return TokenDto.fromJson(result.body);
  //   }

  //   HttpService.badResponseSubject.add(result);
  //   return Future.error(result);
  // }
}
