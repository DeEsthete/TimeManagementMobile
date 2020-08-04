import 'package:time_management_mobile/common/di_config.dart';
import 'package:time_management_mobile/common/enums/selected_duration.dart';
import 'package:time_management_mobile/models/duration_model.dart';
import 'package:time_management_mobile/services/api/period_service.dart';

class CountPeriodsModel extends DurationModel {
  final PeriodService _periodService = getIt<PeriodService>();
  int _count = 0;
  int get count => _count;

  CountPeriodsModel() {
    loadCount();
  }

  void setDuration(SelectedDuration duration) {
    super.setDuration(duration);
    loadCount();
  }

  void loadCount() {
    _periodService.getPeriodsCount(from, to).then((value) => {
          _count = value,
          notifyListeners(),
        });
  }
}
