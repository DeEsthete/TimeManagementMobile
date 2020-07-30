import 'package:flutter/cupertino.dart';
import 'package:time_management_mobile/common/di_config.dart';
import 'package:time_management_mobile/dtos/deed_dto.dart';
import 'package:time_management_mobile/services/api/deed_service.dart';

class DeedsModel extends ChangeNotifier {
  final DeedService _deedService = getIt<DeedService>();
  List<DeedDto> deeds;

  bool _isArchive = false;
  bool get isArchive => _isArchive;
  set isArchive(value) {
    _isArchive = value;
    notifyListeners();
  }

  void loadDeeds({String filter}) {
    _deedService
        .getUserDeeds(isArchiveInclusive: isArchive, filter: filter)
        .then((value) => {
              deeds = value.where((d) => d.isArchived == isArchive).toList(),
              notifyListeners(),
            });
  }

  void archiveDeed(int id) {
    _deedService.archiveDeed(id).then((value) => loadDeeds());
  }

  void unarchiveDeed(int id) {
    _deedService.unarchiveDeed(id).then((value) => loadDeeds());
  }
}
