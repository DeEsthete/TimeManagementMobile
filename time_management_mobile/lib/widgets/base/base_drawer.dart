import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:time_management_mobile/common/selected_screen.dart';
import 'package:time_management_mobile/constant/color_consts.dart';
import 'package:time_management_mobile/utils/session.dart';
import 'package:time_management_mobile/utils/translator.dart';
import 'package:time_management_mobile/widgets/home_screen.dart';

class BaseDrawer extends StatelessWidget {
  final SelectedScreen selected;
  BaseDrawer({this.selected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              image: DecorationImage(
                repeat: ImageRepeat.repeat,
                image: AssetImage("assets/images/drawer_head.png"),
              ),
            ),
            child: Center(
              child: Text(
                Session.tokenDto.userName,
                style: TextStyle(
                  color: AppColors.alterFontColor,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          _buildListItem(
            context: context,
            icon: FontAwesomeIcons.houseUser,
            title: "Home",
            screen: HomeScreen(),
            selected: SelectedScreen.home,
          ),
          _buildListItem(
            context: context,
            icon: FontAwesomeIcons.chartLine,
            title: "Statistic",
            screen: Container(),
            selected: SelectedScreen.statistic,
          ),
          _buildListItem(
            context: context,
            icon: FontAwesomeIcons.alignJustify,
            title: "Schedule",
            screen: Container(),
            selected: SelectedScreen.schedule,
          ),
          _buildListItem(
            context: context,
            icon: FontAwesomeIcons.penAlt,
            title: "Periods",
            screen: Container(),
            selected: SelectedScreen.periods,
          ),
          _buildListItem(
            context: context,
            icon: FontAwesomeIcons.userCheck,
            title: "Deeds",
            screen: Container(),
            selected: SelectedScreen.deeds,
          ),
          _buildListItem(
            context: context,
            icon: FontAwesomeIcons.tasks,
            title: "Purposes",
            screen: Container(),
            selected: SelectedScreen.purposes,
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(
      {BuildContext context,
      IconData icon,
      String title,
      Widget screen,
      SelectedScreen selected}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.mainFontColor.withOpacity(0.15),
          ),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: FaIcon(
                  icon,
                  color: AppColors.primaryColor.withOpacity(0.9),
                ),
              ),
              Expanded(
                flex: 9,
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    Translator.of(context).translate(title),
                    style: TextStyle(
                      color: this.selected == selected
                          ? AppColors.primaryColor
                          : AppColors.mainFontColor.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          if (this.selected != selected) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => screen,
              ),
            );
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
