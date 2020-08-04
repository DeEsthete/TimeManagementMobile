import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_management_mobile/common/enums/selected_screen.dart';
import 'package:time_management_mobile/models/app_language_model.dart';
import 'package:time_management_mobile/utils/translator.dart';
import 'package:time_management_mobile/widgets/base/base_layout.dart';
import 'package:provider/provider.dart';

class PreferencesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = context.watch<AppLanguageModel>();
    return BaseLayout(
      title: "Preferences",
      selected: SelectedScreen.preferences,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              Translator.of(context).translate('Change language'),
              style: TextStyle(fontSize: 32),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {
                      model.changeLanguage(Locale("en"));
                    },
                    child: Text('English'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {
                      model.changeLanguage(Locale("ru"));
                    },
                    child: Text('Русский'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
