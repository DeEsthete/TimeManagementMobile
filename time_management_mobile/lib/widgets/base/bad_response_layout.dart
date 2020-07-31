import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_management_mobile/services/app/http_service.dart';
import 'package:time_management_mobile/utils/translator.dart';

/// Отвечает за отображение диалогового окна при получении ошибки с api
class BadResponseLayout extends StatelessWidget {
  final Widget body;
  BadResponseLayout({@required this.body});

  @override
  Widget build(BuildContext context) {
    HttpService.badResponseSubject.listen((value) {
      String message = "";

      if (value != null) {
        var badResponse = json.decode(value.body);
        if (badResponse["message"] != null) {
          message = badResponse["message"];
        } else {
          message = badResponse["title"];
        }
      } else {
        message = "Unexpected error";
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                Translator.of(context).translate("Error"),
              ),
            ),
            content: Text(
              Translator.of(context).translate(
                message,
              ),
            ),
          );
        },
      );
    });
    return body;
  }
}
