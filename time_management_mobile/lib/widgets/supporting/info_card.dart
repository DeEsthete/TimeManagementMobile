import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_management_mobile/constant/color_consts.dart';
import 'package:time_management_mobile/utils/translator.dart';
import 'package:tinycolor/tinycolor.dart';

class InfoCard extends StatelessWidget {
  static const double defaultPadding = 12.0;
  static const double defaultRadius = 6.0;

  final Widget child;
  final String title;
  final bool isRounded;
  final double paddingTop, paddingBottom, paddingLeft, paddingRight;
  InfoCard({
    @required this.child,
    this.title,
    this.isRounded = true,
    this.paddingTop = defaultPadding,
    this.paddingBottom = defaultPadding,
    this.paddingLeft = defaultPadding,
    this.paddingRight = defaultPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop,
        bottom: paddingBottom,
        left: paddingLeft,
        right: paddingRight,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundColor.withOpacity(0.95),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(isRounded ? defaultRadius : 0),
        ),
        child: Column(
          children: <Widget>[
            title != null
                ? Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: TinyColor(AppColors.primaryColor).lighten(7).color,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(InfoCard.defaultRadius),
                        topRight: Radius.circular(InfoCard.defaultRadius),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        Translator.of(context).translate(title),
                        style: TextStyle(
                          color: AppColors.alterFontColor,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  )
                : Container(),
            child,
          ],
        ),
      ),
    );
  }
}
