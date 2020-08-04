import 'package:time_management_mobile/common/di_config.dart';
import 'package:time_management_mobile/common/enums/selected_duration.dart';
import 'package:time_management_mobile/dtos/deed_dto.dart';
import 'package:time_management_mobile/dtos/deed_periods_count_dto.dart';
import 'package:time_management_mobile/models/duration_model.dart';
import 'package:time_management_mobile/services/api/deed_service.dart';

class DeedsCountModel extends DurationModel {
  final DeedService _deedService = getIt<DeedService>();
  int generalDeeds;
  List<DeedDto> deeds;
  List<DeedPeriodsCountDto> deedPeriodsCounts;

  DeedsCountModel() {
    init();
  }

  void setDuration(SelectedDuration duration) {
    super.setDuration(duration);
    load();
  }

  void init() {
    _deedService.getUserDeeds(isArchiveInclusive: true).then((deedsValue) => {
          deeds = deedsValue,
          load(),
        });
  }

  void load() {
    _deedService.getDeedsPeriodsCount(from, to).then((countsValue) => {
          deedPeriodsCounts = countsValue,
          generalDeeds = deedPeriodsCounts
              .map((e) => e.periodsCount)
              .reduce((a, b) => a + b),
          deeds.sort((a, b) => getDeedPercent(b.id) - getDeedPercent(a.id)),
          notifyListeners(),
        });
  }

  int getDeedPeriodsCount(int deedId) {
    var deedPeriodsCount = deedPeriodsCounts
        .firstWhere((element) => element.deedId == deedId)
        .periodsCount;
    return deedPeriodsCount;
  }

  int getDeedPercent(int deedId) {
    var deedPeriodsCount = getDeedPeriodsCount(deedId);
    var percent = 100 / generalDeeds * deedPeriodsCount;

    if (percent.isNaN) return 0;
    return percent.toInt();
  }
}
