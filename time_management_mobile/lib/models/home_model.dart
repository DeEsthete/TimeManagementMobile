import 'package:flutter/cupertino.dart';
import 'package:time_management_mobile/common/di_config.dart';
import 'package:time_management_mobile/dtos/deed_dto.dart';
import 'package:time_management_mobile/dtos/period_dto.dart';
import 'package:time_management_mobile/services/api/deed_service.dart';
import 'package:time_management_mobile/services/api/period_service.dart';

class HomeModel extends ChangeNotifier {
  final DeedService _deedService = getIt<DeedService>();
  final PeriodService _periodService = getIt<PeriodService>();
  final TextEditingController descriptionController;
  List<DeedDto> deeds = [];

  bool _isRealTime = true;
  bool get isRealTime => _isRealTime;
  set isRealTime(value) {
    _isRealTime = value;
    clear();
  }

  DeedDto selectedDeed;

  DateTime _periodStartDate;
  get periodStartDate => _periodStartDate;
  set periodStartDate(value) {
    _periodStartDate = value;
    notifyListeners();
  }

  DateTime _periodEndDate;
  get periodEndDate => _periodEndDate;
  set periodEndDate(value) {
    _periodEndDate = value;
    notifyListeners();
  }

  HomeModel({this.descriptionController}) {
    _deedService.getUserDeeds().then((value) => {
          deeds = value,
          notifyListeners(),
        });
  }

  void selectDeed(int id) {
    selectedDeed = deeds.firstWhere((d) => d.id == id);
    notifyListeners();
  }

  void startPeriod() {
    if (selectedDeed == null) return;
    _periodStartDate = DateTime.now();
    notifyListeners();
  }

  void stopPeriod() {
    _periodEndDate = DateTime.now();
    createPeriod();
  }

  void createPeriod() {
    PeriodDto periodDto = new PeriodDto(
      deedId: selectedDeed.id,
      startDate: _periodStartDate,
      endDate: _periodEndDate,
      description: descriptionController.text,
    );
    _periodService.createPeriod(periodDto);
    clear();
  }

  void clear() {
    selectedDeed = null;
    _periodStartDate = null;
    _periodEndDate = null;
    descriptionController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    this._deedService?.dispose();
    super.dispose();
  }
}
