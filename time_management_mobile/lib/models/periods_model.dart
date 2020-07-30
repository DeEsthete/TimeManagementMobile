import 'package:flutter/cupertino.dart';
import 'package:time_management_mobile/common/di_config.dart';
import 'package:time_management_mobile/dtos/deed_dto.dart';
import 'package:time_management_mobile/dtos/period_dto.dart';
import 'package:time_management_mobile/services/api/deed_service.dart';
import 'package:time_management_mobile/services/api/period_service.dart';

class PeriodsModel extends ChangeNotifier {
  final PeriodService _periodService = getIt<PeriodService>();
  final DeedService _deedService = getIt<DeedService>();
  List<PeriodDto> periods;
  List<DeedDto> deeds;

  DateTime _from = DateTime.now().add(Duration(days: -7));
  DateTime get from => _from;
  set from(value) {
    _from = value;
    loadPeriods();
  }

  DateTime _to = DateTime.now();
  DateTime get to => _to;
  set to(value) {
    _to = value;
    loadPeriods();
  }

  PeriodsModel() {
    init();
  }

  void init() {
    _deedService
        .getUserDeeds(isArchiveInclusive: true)
        .then((value) => {deeds = value, loadPeriods()});
  }

  void loadPeriods() {
    periods = null;
    notifyListeners();
    _periodService
        .getPeriodsByDate(_from, _to)
        .then((value) => {periods = value, notifyListeners()});
  }

  DeedDto getDeed(int id) {
    return deeds.firstWhere((d) => d.id == id);
  }

  void deletePeriod(int id) {
    var period = periods.firstWhere((p) => p.id == id);
    periods.remove(period);
    _periodService.removePeriod(id).catchError(() => periods.add(period));
  }
}
