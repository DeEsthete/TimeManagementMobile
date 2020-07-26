import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_management_mobile/models/bad_response_model.dart';
import 'package:time_management_mobile/utils/translator.dart';

class BadResponseLayout extends StatelessWidget {
  final Widget child;
  BadResponseLayout({@required this.child});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        child,
        Consumer<BadResponseModel>(
          builder: (context, value, child) {
            if (value.badResponse != null) {
              return new Positioned(
                left: 0.0,
                bottom: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Container(
                    width: double.infinity,
                    height: 80.0,
                    decoration: new BoxDecoration(color: Colors.red),
                    child: Center(
                      child: new Text(
                        value.badResponse.statusCode.toString() +
                            ": " +
                            Translator.of(context)
                                .translate(value.badResponse.message),
                      ),
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        )
      ],
    );
  }
}
