import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_management_mobile/models/session_model.dart';
import 'package:time_management_mobile/utils/translator.dart';
import 'package:time_management_mobile/widgets/base/bad_response_layout.dart';

class AuthScreen extends StatelessWidget {
  final TextEditingController _userNameController = new TextEditingController(
    text: "DefaultUser",
  );
  final TextEditingController _passwordController = new TextEditingController(
    text: "DefaultUser",
  );

  @override
  Widget build(BuildContext context) {
    var sessionModel = Provider.of<SessionModel>(context);
    return Scaffold(
      body: BadResponseLayout(
        body: Container(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: TextFormField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                      hintText: Translator.of(context).translate("Username"),
                    ),
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: Translator.of(context).translate("Password"),
                    ),
                    obscureText: true,
                  ),
                ),
                RaisedButton(
                  onPressed: () => {
                    sessionModel.logIn(
                      _userNameController.value.text,
                      _passwordController.value.text,
                    )
                  },
                  child: Center(
                    child: Text(
                      Translator.of(context).translate("Sign in"),
                    ),
                  ),
                ),
                FlatButton(
                  // TODO: Добавить navigation на регистрацию
                  onPressed: () => {},
                  child: Center(
                    child: Center(
                      child: Text(
                        Translator.of(context).translate("Sign up"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
