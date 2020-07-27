import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_management_mobile/dtos/bad_response_dto.dart';
import 'package:time_management_mobile/services/app/http_service.dart';
import 'package:time_management_mobile/utils/translator.dart';

class BadResponseLayout extends StatelessWidget {
  final Widget body;
  BadResponseLayout({@required this.body});

  @override
  Widget build(BuildContext context) {
    HttpService.badResponseSubject.listen((value) {
      var badResponse = BadResponseDto.fromJson(value.body);
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
                badResponse.message.toString(),
              ),
            ),
          );
        },
      );
    });
    return body;
  }
}
