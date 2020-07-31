import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_management_mobile/constant/color_consts.dart';

class InfoCard extends StatelessWidget {
  static const double defaultPadding = 12.0;

  final Widget child;
  final bool isRounded;
  final double paddingTop, paddingBottom, paddingLeft, paddingRight;
  InfoCard({
    @required this.child,
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
          borderRadius: BorderRadius.circular(isRounded ? 6.0 : 0),
        ),
        child: child,
      ),
    );
  }
}
