import 'package:flutter/foundation.dart';
import 'package:time_management_mobile/utils/session.dart';

class SessionModel extends ChangeNotifier {
  bool isSignedIn = false;

  SessionModel() {
    Session.isSignedInSubject.listen((value) {
      isSignedIn = value;
      notifyListeners();
    });
  }

  logIn(String userName, String password) {
    Session.logIn(userName, password);
  }

  logOut() {
    Session.logOut();
  }
}
