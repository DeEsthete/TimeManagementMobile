import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_management_mobile/common/di_config.dart';
import 'package:time_management_mobile/dtos/registration_dto.dart';
import 'package:time_management_mobile/models/session_model.dart';
import 'package:time_management_mobile/services/api/user_service.dart';
import 'package:time_management_mobile/utils/translator.dart';
import 'package:time_management_mobile/widgets/base/bad_response_layout.dart';

class AuthScreen extends StatelessWidget {
  final UserService _userService = getIt<UserService>();
  final TextEditingController _userNameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

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
                      onPressed: () => {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return _buildRegistration(context);
                          },
                        )
                      },
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

  Widget _buildRegistration(BuildContext context) {
    final TextEditingController _userNameController =
        new TextEditingController();
    final TextEditingController _nickNameController =
        new TextEditingController();
    final TextEditingController _passwordController =
        new TextEditingController();

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  Translator.of(context).translate("Sign up"),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
                  controller: _nickNameController,
                  decoration: InputDecoration(
                    hintText: Translator.of(context).translate("Password"),
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
                    _userService
                        .registration(
                          new RegistrationDto(
                            nickname: _nickNameController.text,
                            userName: _userNameController.text,
                            password: _passwordController.text,
                          ),
                        )
                        .then((value) => Navigator.pop(context)),
                  },
                  child: Center(
                    child: Text(
                      Translator.of(context).translate("Sign up"),
                    ),
                  ),
                ),
              ),
              Container(
                width: 200,
                child: FlatButton(
                  onPressed: () => {
                    Navigator.pop(context),
                  },
                  child: Center(
                    child: Center(
                      child: Text(
                        Translator.of(context).translate("Sign in"),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
