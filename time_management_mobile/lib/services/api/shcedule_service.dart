import 'dart:convert';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:time_management_mobile/constant/filter_consts.dart';
import 'package:time_management_mobile/constant/route_consts.dart';
import 'package:time_management_mobile/dtos/schedule_dto.dart';
import 'package:time_management_mobile/dtos/schedule_period_dto.dart';
import 'package:time_management_mobile/services/app/http_service.dart';

@injectable
class ScheduleService {
  final _root = Routes.root + 'schedules/';
  Client _client = HttpService();

  Future<int> createSchedule(ScheduleDto schedule) async {
    var response = await _client.post(_root, body: schedule.toJson());
    if (HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      return json.decode(response.body);
    }
    return Future.error(response);
  }

  Future<int> addSchedulePeriod(SchedulePeriodDto schedulePeriod) async {
    var response = await _client.post(
      _root + "period",
      body: schedulePeriod.toJson(),
    );
    if (HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      return json.decode(response.body);
    }
    return Future.error(response);
  }

  Future<ScheduleDto> getScheduleByDate(DateTime scheduleDate) async {
    var response = await _client.get(
      _root + scheduleDate.toIso8601String(),
    );
    if (HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      return response.body != "" ? ScheduleDto.fromJson(response.body) : null;
    }
    return Future.error(response);
  }

  Future<List<ScheduleDto>> getScheduleByDateRange(
      DateTime from, DateTime to) async {
    var response = await _client.get(
      _root + from.toIso8601String() + "/" + to.toIso8601String(),
    );
    if (HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      return List.from(json.decode(response.body))
          .map((model) => ScheduleDto.fromMap(model))
          .toList();
    }
    return Future.error(response);
  }

  Future<List<SchedulePeriodDto>> getPeriodsByScheduleId(int scheduleId) async {
    var response = await _client.get(
      _root + "periods/" + scheduleId.toString(),
    );
    if (HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      return List.from(json.decode(response.body))
          .map((model) => SchedulePeriodDto.fromMap(model))
          .toList();
    }
    return Future.error(response);
  }

  void dispose() {
    _client?.close();
  }
}
