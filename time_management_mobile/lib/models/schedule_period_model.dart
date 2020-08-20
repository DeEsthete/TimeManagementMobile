import 'package:flutter/cupertino.dart';
import 'package:time_management_mobile/common/di_config.dart';

import 'package:time_management_mobile/dtos/deed_dto.dart';
import 'package:time_management_mobile/dtos/schedule_period_dto.dart';
import 'package:time_management_mobile/services/api/deed_service.dart';

class SchedulePeriodModel extends ChangeNotifier {
  final DeedService _deedService = getIt<DeedService>();
  final TextEditingController descriptionController;

  List<DeedDto> deeds = [];
  DeedDto selectedDeed;

  DateTime _periodStartDate;
  get periodStartDate => _periodStartDate;
  set periodStartDate(value) {
    _periodStartDate = value;
    notifyListeners();
  }

  get periodEndDate => _periodEndDate;
  set periodEndDate(value) {
    _periodEndDate = value;
    notifyListeners();
  }

  DateTime _periodEndDate;
  SchedulePeriodModel({@required this.descriptionController}) {
    _deedService.getUserDeeds().then((value) => {
          deeds = value,
          notifyListeners(),
        });
  }

  void selectDeed(int id) {
    selectedDeed = deeds.firstWhere((d) => d.id == id);
    notifyListeners();
  }

  SchedulePeriodDto getPeriod() {
    SchedulePeriodDto periodDto = new SchedulePeriodDto(
      deedId: selectedDeed.id,
      startDate: _periodStartDate,
      endDate: _periodEndDate,
      description: descriptionController.text,
    );
    clearPeriod();
    return periodDto;
  }

  void clearPeriod() {
    selectedDeed = null;
    _periodStartDate = null;
    _periodEndDate = null;
    descriptionController.clear();
    notifyListeners();
  }
}
