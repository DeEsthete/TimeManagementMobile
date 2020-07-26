import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:time_management_mobile/models/app_language_model.dart';
import 'package:time_management_mobile/models/session_model.dart';
import 'package:time_management_mobile/utils/translator.dart';
import 'package:time_management_mobile/widgets/auth_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.watch<AppLanguageModel>().appLocal,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ],
      localizationsDelegates: [
        Translator.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Consumer<SessionModel>(
        builder: (context, value, child) {
          if (value.isSignedIn) {
            return Container();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
