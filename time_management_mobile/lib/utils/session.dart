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
    var tokenDtoJson = prefs.get(AuthPrefsConsts.tokenKey);

    if (tokenDtoJson != null) {
      Session._tokenDto = TokenDto.fromJson(tokenDtoJson);
      _isSignedInSubject.add(true);
    } else {
      _isSignedInSubject.add(false);
    }
  }

  static Future logIn(String userName, String password) async {
    AuthService _authService = getIt<AuthService>();
    var authenticationDto = new AuthenticationDto(
      username: userName,
      password: password,
    );
    _authService.authenticate(authenticationDto).then(
          (value) async => {
            await _saveData(value, authenticationDto),
            _isSignedInSubject.add(true),
          },
        );
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

  static Future _saveData(
      TokenDto tokenDto, AuthenticationDto authenticationDto) async {
    _tokenDto = tokenDto;
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(AuthPrefsConsts.tokenKey, tokenDto.toJson());
    prefs.setString(AuthPrefsConsts.passKey, authenticationDto.toJson());
  }
}
