import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_management_mobile/common/di_config.dart';
import 'package:time_management_mobile/constant/filter_consts.dart';
import 'package:time_management_mobile/constant/pref_consts.dart';
import 'package:time_management_mobile/dtos/authentication_dto.dart';
import 'package:time_management_mobile/services/api/user_service.dart';
import 'package:time_management_mobile/utils/session.dart';

/// Прослойка для [Client].
class HttpService implements Client {
  final Client _client = Client();

  static BehaviorSubject<Response> _badResponseSubject = new BehaviorSubject();
  static BehaviorSubject<Response> get badResponseSubject =>
      _badResponseSubject;

  @override
  Future<Response> get(url, {Map<String, String> headers}) {
    if (headers == null) headers = new Map<String, String>();
    _insertDefaultHeaders(headers);
    return _makeRequest(() => _client.get(url, headers: headers));
  }

  @override
  Future<Response> post(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    if (headers == null) headers = new Map<String, String>();
    _insertDefaultHeaders(headers);
    return _makeRequest(() => _client.post(
          url,
          headers: headers,
          body: body,
          encoding: encoding,
        ));
  }

  @override
  Future<Response> put(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    if (headers == null) headers = new Map<String, String>();
    _insertDefaultHeaders(headers);
    return _makeRequest(() => _client.put(
          url,
          headers: headers,
          body: body,
          encoding: encoding,
        ));
  }

  @override
  Future<Response> patch(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    if (headers == null) headers = new Map<String, String>();
    _insertDefaultHeaders(headers);
    return _makeRequest(() => _client.patch(
          url,
          headers: headers,
          body: body,
          encoding: encoding,
        ));
  }

  @override
  Future<Response> head(url, {Map<String, String> headers}) {
    if (headers == null) headers = new Map<String, String>();
    _insertDefaultHeaders(headers);
    return _makeRequest(() => _client.head(url, headers: headers));
  }

  @override
  Future<Response> delete(url, {Map<String, String> headers}) {
    if (headers == null) headers = new Map<String, String>();
    _insertDefaultHeaders(headers);
    return _makeRequest(() => _client.delete(url, headers: headers));
  }

  @override
  Future<String> read(url, {Map<String, String> headers}) {
    if (headers == null) headers = new Map<String, String>();
    _insertDefaultHeaders(headers);
    return _client.read(url, headers: headers);
  }

  @override
  Future<Uint8List> readBytes(url, {Map<String, String> headers}) {
    if (headers == null) headers = new Map<String, String>();
    _insertDefaultHeaders(headers);
    return _client.readBytes(url, headers: headers);
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    _insertDefaultHeaders(request.headers);
    return _client.send(request);
  }

  Future<Response> _makeRequest(Function _requester) async {
    var response = await _requester();

    if (response.statusCode == HttpStatus.unauthorized) {
      try {
        await _refreshAuthToken();
        response = await _requester();
      } on Exception {
        Session.getInstance().isSignedInSubject.add(false);
      }
    }

    // Сообщаем что запрос выполнился с ошибкой
    if (!HttpResults.allowedHttpStatuses.contains(response.statusCode)) {
      HttpService.badResponseSubject.add(response);
      Future.error(response);
    }

    return response;
  }

  Future _refreshAuthToken() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(AuthPrefsConsts.passKey)) {
      throw Exception('An error occured while trying to refresh auth token');
    }

    var authenticationDto = AuthenticationDto.fromJson(
      prefs.get(AuthPrefsConsts.passKey),
    );
    UserService _authService = getIt.get<UserService>();
    await _authService.authenticate(authenticationDto);
  }

  void _insertDefaultHeaders(Map<String, String> headers) {
    headers['content-type'] = 'application/json';
    headers['accept'] = 'application/json';
    if (Session.getInstance().tokenDto != null) {
      headers['Authorization'] =
          'Bearer ' + Session.getInstance().tokenDto.accessToken;
    }
  }

  static void closeSubjects() {
    _badResponseSubject.close();
  }

  @override
  void close() {
    _client.close();
  }

  void dispose() {
    close();
  }
}
