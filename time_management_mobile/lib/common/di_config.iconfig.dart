// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:time_management_mobile/services/api/deed_service.dart';
import 'package:time_management_mobile/services/api/period_service.dart';
import 'package:time_management_mobile/services/api/purpose_service.dart';
import 'package:time_management_mobile/services/api/shcedule_service.dart';
import 'package:time_management_mobile/services/api/user_service.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerFactory<DeedService>(() => DeedService());
  g.registerFactory<PeriodService>(() => PeriodService());
  g.registerFactory<PurposeService>(() => PurposeService());
  g.registerFactory<ScheduleService>(() => ScheduleService());
  g.registerFactory<UserService>(() => UserService());
}
