import 'dart:convert';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:time_management_mobile/constant/filter_consts.dart';
import 'package:time_management_mobile/constant/route_consts.dart';
import 'package:time_management_mobile/dtos/deed_dto.dart';
import 'package:time_management_mobile/dtos/deed_periods_count_dto.dart';
import 'package:time_management_mobile/services/app/http_service.dart';

@injectable
class DeedService {
  final _root = Routes.root + 'deeds/';
  Client _client = HttpService();

  Future<int> createDeed(DeedDto deed) async {
    var response = await _client.post(_root, body: deed);
    if (HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      return json.decode(response.body);
    }
    return Future.error(response);
  }

  Future updateDeed(DeedDto deed) async {
    var response = await _client.put(_root, body: deed);
    if (HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      return;
    }
    return Future.error(response);
  }

  Future<List<DeedDto>> getUserDeeds(
      {bool isArchiveInclusive = false, String filter = ""}) async {
    var response = await _client.get(
      _root + isArchiveInclusive.toString() + "?filter=" + filter,
    );
    if (HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      return List.from(json.decode(response.body))
          .map((model) => DeedDto.fromMap(model))
          .toList();
    }
    return Future.error(response);
  }

  Future<List<DeedPeriodsCountDto>> getDeedsPeriodsCount(
      DateTime from, DateTime to) async {
    var response = await _client.get(
      _root + "periods-count/" + from.toString() + "/" + to.toString(),
    );
    if (HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      return List.from(json.decode(response.body))
          .map((model) => DeedPeriodsCountDto.fromMap(model))
          .toList();
    }
    return Future.error(response);
  }

  Future archiveDeed(int deedId) async {
    var response = await _client.post(_root + "archive/" + deedId.toString());
    if (HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      return;
    }
    return Future.error(response);
  }

  Future unarchiveDeed(int deedId) async {
    var response = await _client.post(_root + "unarchive/" + deedId.toString());
    if (HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      return;
    }
    return Future.error(response);
  }

  void dispose() {
    if (_client != null) {
      _client.close();
    }
  }
}
