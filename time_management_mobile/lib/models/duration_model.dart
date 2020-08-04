import 'package:flutter/cupertino.dart';
import 'package:time_management_mobile/common/enums/selected_duration.dart';

abstract class DurationModel extends ChangeNotifier {
  SelectedDuration _duration = SelectedDuration.day;
  SelectedDuration get duration => _duration;

  DateTime _from = DateTime.now().add(Duration(days: -1));
  DateTime get from => _from;
  DateTime _to = DateTime.now();
  DateTime get to => _to;

  void setDuration(SelectedDuration duration) {
    switch (duration) {
      case SelectedDuration.day:
        _from = DateTime.now().add(Duration(days: -1));
        break;
      case SelectedDuration.week:
        _from = DateTime.now().add(Duration(days: -7));
        break;
      case SelectedDuration.month:
        _from = DateTime.now().add(Duration(days: -31));
        break;
      case SelectedDuration.year:
        _from = DateTime.now().add(Duration(days: -365));
        break;
      default:
    }
    _duration = duration;
  }
}
