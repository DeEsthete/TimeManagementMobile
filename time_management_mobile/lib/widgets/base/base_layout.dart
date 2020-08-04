import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_management_mobile/common/enums/selected_screen.dart';
import 'package:time_management_mobile/utils/translator.dart';
import 'package:time_management_mobile/widgets/base/bad_response_layout.dart';
import 'package:time_management_mobile/widgets/base/base_drawer.dart';

/// Базовая обертка для скринов
class BaseLayout extends StatelessWidget {
  final Widget body;
  final String title;
  final SelectedScreen selected;
  BaseLayout({@required this.body, this.title, this.selected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: title != null
            ? Text(
                Translator.of(context).translate(title),
              )
            : Container(),
      ),
      drawer: BaseDrawer(
        selected: selected,
      ),
      body: BadResponseLayout(body: body),
    );
  }
}
