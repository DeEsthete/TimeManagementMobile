import 'package:flutter/cupertino.dart';
import 'package:time_management_mobile/common/di_config.dart';
import 'package:time_management_mobile/constant/date_consts.dart';
import 'package:time_management_mobile/dtos/deed_dto.dart';
import 'package:time_management_mobile/dtos/schedule_dto.dart';
import 'package:time_management_mobile/services/api/deed_service.dart';
import 'package:time_management_mobile/services/api/shcedule_service.dart';

class SchedulesModel extends ChangeNotifier {
  final ScheduleService _scheduleService = getIt<ScheduleService>();
  final DeedService _deedService = getIt<DeedService>();
  ScheduleService get scheduleService => _scheduleService;

  List<ScheduleDto> schedules;
  ScheduleDto todaySchedule;
  List<DeedDto> deeds;

  bool _isHistory = false;
  bool get isHistory => _isHistory;
  set isHistory(value) {
    _isHistory = value;
    notifyListeners();
  }

  SchedulesModel() {
    init();
  }

  void init() {
    _deedService.getUserDeeds(isArchiveInclusive: true).then((value) => {
          deeds = value,
          loadTodaySchedule(),
        });
  }

  void loadTodaySchedule() {
    _scheduleService.getScheduleByDate(DateTime.now()).then((value) => {
          todaySchedule = value,
          loadSchedules(),
        });
  }

  void loadSchedules() {
    var from = _isHistory ? DateConsts.minDate : DateTime.now();
    var to = _isHistory ? DateTime.now() : DateConsts.maxDate;
    _scheduleService.getScheduleByDateRange(from, to).then((value) => {
          schedules = value,
          notifyListeners(),
        });
  }

  DeedDto getDeed(int id) {
    return deeds.firstWhere((d) => d.id == id);
  }
}
