import 'package:flutter/cupertino.dart';
import 'package:time_management_mobile/common/di_config.dart';
import 'package:time_management_mobile/dtos/deed_dto.dart';
import 'package:time_management_mobile/dtos/schedule_dto.dart';
import 'package:time_management_mobile/dtos/schedule_period_dto.dart';
import 'package:time_management_mobile/services/api/deed_service.dart';
import 'package:time_management_mobile/services/api/shcedule_service.dart';

class ScheduleCreateModel extends ChangeNotifier {
  final ScheduleService _scheduleService = getIt<ScheduleService>();
  final DeedService _deedService = getIt<DeedService>();

  DateTime _scheduleDate = DateTime.now().add(Duration(days: 1));
  DateTime get scheduleDate => _scheduleDate;
  set scheduleDate(value) {
    _scheduleDate = value;
    notifyListeners();
  }

  List<SchedulePeriodDto> schedulePeriods = [];

  List<DeedDto> deeds = [];

  ScheduleCreateModel() {
    _deedService.getUserDeeds().then((value) => {
          deeds = value,
          notifyListeners(),
        });
  }

  void addPeriod(SchedulePeriodDto periodDto) {
    periodDto.startDate = _scheduleDate.add(Duration(
        hours: periodDto.startDate.hour, minutes: periodDto.startDate.minute));
    periodDto.endDate = _scheduleDate.add(Duration(
        hours: periodDto.endDate.hour, minutes: periodDto.endDate.minute));
    schedulePeriods.add(periodDto);
    notifyListeners();
  }

  void createSchedule() {
    if (schedulePeriods.isEmpty) return;

    ScheduleDto schedule = new ScheduleDto(
      scheduleDate: _scheduleDate,
    );
    _scheduleService.createSchedule(schedule).then((value) => {
          schedulePeriods.forEach((p) {
            p.scheduleId = value;
            _scheduleService.addSchedulePeriod(p);
          })
        });
  }

  void deletePeriod(SchedulePeriodDto periodDto) {
    schedulePeriods.remove(periodDto);
    notifyListeners();
  }

  void clearSchedule() {
    _scheduleDate = null;
    schedulePeriods.clear();
    notifyListeners();
  }

  DeedDto getDeed(int id) {
    return deeds.firstWhere((d) => d.id == id);
  }
}
