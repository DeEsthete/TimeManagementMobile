import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:time_management_mobile/constant/color_consts.dart';
import 'package:time_management_mobile/models/app_language_model.dart';
import 'package:time_management_mobile/models/session_model.dart';
import 'package:time_management_mobile/utils/translator.dart';
import 'package:time_management_mobile/widgets/screens/auth_screen.dart';
import 'package:time_management_mobile/widgets/screens/home_screen.dart';

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
      title: 'Time Management',
      theme: ThemeData(
        primarySwatch: AppColors.primaryColor,
        accentColor: AppColors.accentColor,
        buttonColor: AppColors.primaryColor,
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Consumer<SessionModel>(
        builder: (context, value, child) {
          if (value.isSignedIn) {
            return HomeScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
