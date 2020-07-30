import 'dart:convert';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:time_management_mobile/constant/filter_consts.dart';
import 'package:time_management_mobile/constant/route_consts.dart';
import 'package:time_management_mobile/dtos/purpose_dto.dart';
import 'package:time_management_mobile/services/app/http_service.dart';

@injectable
class PurposeService {
  final _root = Routes.root + 'purposes/';
  Client _client = HttpService();

  Future<int> createPurpose(PurposeDto purpose) async {
    var response = await _client.post(_root, body: purpose.toJson());
    if (HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      return json.decode(response.body);
    }
    return Future.error(response);
  }

  Future updatePurpose(PurposeDto purpose) async {
    var response = await _client.put(_root, body: purpose.toJson());
    if (HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      return;
    }
    return Future.error(response);
  }

  Future<List<PurposeDto>> getPeriodsByDate(String statusCode) async {
    var response = await _client.get(
      _root + statusCode,
    );
    if (HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      return List.from(json.decode(response.body))
          .map((model) => PurposeDto.fromMap(model))
          .toList();
    }
    return Future.error(response);
  }

  void dispose() {
    _client?.close();
  }
}
