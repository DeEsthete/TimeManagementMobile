import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_management_mobile/common/di_config.dart';
import 'package:time_management_mobile/constant/pref_consts.dart';
import 'package:time_management_mobile/dtos/authentication_dto.dart';
import 'package:time_management_mobile/dtos/token_dto.dart';
import 'package:time_management_mobile/services/api/auth_service.dart';

class Session {
  static TokenDto _tokenDto;
  static TokenDto get tokenDto => _tokenDto;

  static BehaviorSubject<bool> _isSignedInSubject = new BehaviorSubject();
  static BehaviorSubject<bool> get isSignedInSubject => _isSignedInSubject;

  static bool _isSignedIn;
  static bool get isSignedIn => _isSignedIn;

  Session() {
    _isSignedInSubject.listen((value) {
      _isSignedIn = value;
    });
  }

  static Future init() async {
    var prefs = await SharedPreferences.getInstance();
    Session._tokenDto = prefs.get(AuthPrefsConsts.tokenKey);
    if (Session._tokenDto != null) {
      _isSignedInSubject.add(true);
    }
    _isSignedInSubject.add(false);
  }

  static Future logIn(String userName, String password) async {
    AuthService _authService = getIt<AuthService>();
    var authenticationDto = new AuthenticationDto(
      username: userName,
      password: password,
    );
    var tokenDto = await _authService.authenticate(authenticationDto);
    _tokenDto = tokenDto;

    var prefs = await SharedPreferences.getInstance();
    prefs.setString(AuthPrefsConsts.tokenKey, json.encode(tokenDto));
    prefs.setString(AuthPrefsConsts.passKey, json.encode(authenticationDto));

    _isSignedInSubject.add(true);
  }

  static Future logOut() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(AuthPrefsConsts.tokenKey);
    prefs.remove(AuthPrefsConsts.passKey);
    _isSignedInSubject.add(false);
  }

  static void closeSubjects() {
    _isSignedInSubject.close();
  }
}
