import 'package:flutter/foundation.dart';
import 'package:time_management_mobile/utils/session.dart';

class SessionModel extends ChangeNotifier {
  bool isSignedIn = false;

  SessionModel() {
    Session.getInstance().isSignedInSubject.listen((value) {
      isSignedIn = value;
      notifyListeners();
    });
  }

  logIn(String userName, String password) {
    Session.getInstance().logIn(userName, password);
  }

  logOut() {
    Session.getInstance().logOut();
  }

  @override
  void dispose() {
    super.dispose();
    Session.getInstance().dispose();
  }
}
