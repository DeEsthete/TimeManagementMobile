import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:time_management_mobile/dtos/bad_response_dto.dart';
import 'package:time_management_mobile/services/app/http_service.dart';

class BadResponseModel extends ChangeNotifier {
  BadResponseDto badResponse;

  BadResponseModel() {
    HttpService.badResponseSubject.listen((value) {
      badResponse = BadResponseDto.fromJson(json.decode(value.body));
      notifyListeners();
    });
  }
}
