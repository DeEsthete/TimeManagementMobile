import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_management_mobile/common/di_config.dart';
import 'package:time_management_mobile/constant/pref_consts.dart';
import 'package:time_management_mobile/dtos/authentication_dto.dart';
import 'package:time_management_mobile/dtos/token_dto.dart';
import 'package:time_management_mobile/services/api/user_service.dart';

class Session {
  static Session _instance;

  TokenDto _tokenDto;
  TokenDto get tokenDto => _tokenDto;

  BehaviorSubject<bool> _isSignedInSubject = new BehaviorSubject();
  BehaviorSubject<bool> get isSignedInSubject => _isSignedInSubject;

  bool _isSignedIn;
  bool get isSignedIn => _isSignedIn;

  Session() {
    _isSignedInSubject.listen((value) {
      _isSignedIn = value;
    });
  }

  static Session getInstance() {
    if (_instance == null) {
      _instance = Session();
    }
    return _instance;
  }

  Future init() async {
    var prefs = await SharedPreferences.getInstance();
    var tokenDtoJson = prefs.get(AuthPrefsConsts.tokenKey);

    if (tokenDtoJson != null) {
      _tokenDto = TokenDto.fromJson(tokenDtoJson);
      _isSignedInSubject.add(true);
    } else {
      _isSignedInSubject.add(false);
    }
  }

  Future logIn(String userName, String password) async {
    UserService _authService = getIt<UserService>();
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

  Future logOut() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(AuthPrefsConsts.tokenKey);
    prefs.remove(AuthPrefsConsts.passKey);
    _isSignedInSubject.add(false);
  }

  Future _saveData(
      TokenDto tokenDto, AuthenticationDto authenticationDto) async {
    _tokenDto = tokenDto;
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(AuthPrefsConsts.tokenKey, tokenDto.toJson());
    prefs.setString(AuthPrefsConsts.passKey, authenticationDto.toJson());
  }

  void dispose() {
    _isSignedInSubject.close();
  }
}
