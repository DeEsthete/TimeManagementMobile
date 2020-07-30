import 'dart:convert';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:time_management_mobile/constant/filter_consts.dart';
import 'package:time_management_mobile/constant/route_consts.dart';
import 'package:time_management_mobile/dtos/period_dto.dart';
import 'package:time_management_mobile/services/app/http_service.dart';

@injectable
class PeriodService {
  final _root = Routes.root + 'periods/';
  Client _client = HttpService();

  Future<int> createPeriod(PeriodDto period) async {
    var response = await _client.post(_root, body: period.toJson());
    if (HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      return json.decode(response.body);
    }
    return Future.error(response);
  }

  Future updatePeriod(PeriodDto period) async {
    var response = await _client.put(_root, body: period.toJson());
    if (HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      return;
    }
    return Future.error(response);
  }

  Future<List<PeriodDto>> getPeriodsByDate(DateTime from, DateTime to) async {
    var response = await _client.get(
      _root + from.toString() + "/" + to.toString(),
    );
    if (HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      return List.from(json.decode(response.body))
          .map((model) => PeriodDto.fromMap(model))
          .toList();
    }
    return Future.error(response);
  }

  Future<int> getPeriodsCount() async {
    var response = await _client.get(_root + "count");
    if (HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      return json.decode(response.body);
    }
    return Future.error(response);
  }

  Future<PeriodDto> getLastPeriod() async {
    var response = await _client.get(_root);
    if (HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      return PeriodDto.fromJson(response.body);
    }
    return Future.error(response);
  }

  Future removePeriod(int periodId) async {
    var response = await _client.delete(_root);
    if (HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      return;
    }
    return Future.error(response);
  }

  void dispose() {
    _client?.close();
  }
}
