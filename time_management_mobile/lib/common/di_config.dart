import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di_config.iconfig.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies() => $initGetIt(getIt);
