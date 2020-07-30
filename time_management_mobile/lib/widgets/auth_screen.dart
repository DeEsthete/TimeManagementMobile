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
      appBar: AppBar(
        title: Center(
          child: Text(
            Translator.of(context).translate("Sign in "),
          ),
        ),
      ),
      body: BadResponseLayout(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
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
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 200,
                    child: RaisedButton(
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
                  ),
                  Container(
                    width: 200,
                    child: FlatButton(
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
