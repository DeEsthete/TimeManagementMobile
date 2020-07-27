import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_management_mobile/models/session_model.dart';
import 'package:time_management_mobile/utils/session.dart';

import 'common/di_config.dart';
import 'models/app_language_model.dart';
import 'widgets/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguageModel appLanguage = AppLanguageModel();
  await appLanguage.fetchLocale();
  await Session.init();
  configureDependencies();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SessionModel>(
          create: (context) => SessionModel(),
        ),
        ChangeNotifierProvider.value(value: appLanguage),
      ],
      child: MyApp(),
    ),
  );
}
