import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:time_management_mobile/common/enums/selected_screen.dart';
import 'package:time_management_mobile/constant/color_consts.dart';
import 'package:time_management_mobile/models/home_model.dart';
import 'package:time_management_mobile/utils/translator.dart';
import 'package:time_management_mobile/widgets/base/base_layout.dart';
import 'package:time_management_mobile/widgets/supporting/info_card.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _descriptionController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: "Home",
      selected: SelectedScreen.home,
      body: Container(
        child: ChangeNotifierProvider(
          create: (context) => new HomeModel(
            descriptionController: _descriptionController,
          ),
          child: Consumer<HomeModel>(
            builder: (context, model, child) {
              return Column(
                children: <Widget>[
                  _buildNavigation(context, model),
                  Expanded(
                    child: model.isRealTime
                        ? _buildForRealTime(context, model)
                        : _buildForHistory(context, model),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNavigation(BuildContext context, HomeModel model) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _buildNavigationSegment(context, model, true),
        ),
        Expanded(
          child: _buildNavigationSegment(context, model, false),
        ),
      ],
    );
  }

  Widget _buildForRealTime(BuildContext context, HomeModel model) {
    return Stack(
      children: <Widget>[
        Container(
          height: 230,
          child: InfoCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: DropdownButton(
                    value: model.selectedDeed?.id,
                    hint: Text(
                      Translator.of(context)
                          .translate("Change deed for current period"),
                    ),
                    items: model.deeds
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(e.name),
                            value: e.id,
                          ),
                        )
                        .toList(),
                    onChanged: (value) => {model.selectDeed(value)},
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: TextFormField(
                      minLines: 3,
                      maxLines: 3,
                      controller: model.descriptionController,
                      decoration: InputDecoration(
                        hintText: Translator.of(context)
                            .translate("Period description"),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          top: 200,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (model.periodStartDate == null
                            ? AppColors.primaryColor
                            : Colors.red)
                        .withOpacity(0.5),
                    spreadRadius: 40,
                    blurRadius: 100,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: new SizedBox(
                height: 150,
                width: 150,
                child: model.periodStartDate == null
                    ? _buildActionButton(
                        context: context,
                        color: AppColors.primaryColor,
                        text: "Start",
                        action: () => {
                          model.startPeriod(),
                        },
                      )
                    : _buildActionButton(
                        context: context,
                        color: Colors.red,
                        text: "Stop",
                        action: () => {
                          model.stopPeriod(),
                        },
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForHistory(BuildContext context, HomeModel model) {
    return InfoCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: DropdownButton(
              value: model.selectedDeed?.id,
              hint: Text(
                Translator.of(context)
                    .translate("Change deed for current period"),
              ),
              items: model.deeds
                  .map(
                    (e) => DropdownMenuItem(
                      child: Text(e.name),
                      value: e.id,
                    ),
                  )
                  .toList(),
              onChanged: (value) => {model.selectDeed(value)},
            ),
          ),
          _buildDateTimePicker(context, model, true),
          _buildDateTimePicker(context, model, false),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextFormField(
                minLines: 4,
                maxLines: 4,
                controller: model.descriptionController,
                decoration: InputDecoration(
                  hintText:
                      Translator.of(context).translate("Period description"),
                ),
              ),
            ),
          ),
          Container(
            child: RaisedButton(
              onPressed: () => {model.createPeriod()},
              child: Text(
                Translator.of(context).translate("Create period"),
                style: TextStyle(fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNavigationSegment(
      BuildContext context, HomeModel model, bool isRealTime) {
    return GestureDetector(
      child: Container(
        color: model.isRealTime == isRealTime
            ? Colors.transparent
            : Colors.black.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(5.5),
          child: Center(
            child: Text(
              Translator.of(context).translate(
                isRealTime ? "Real time" : "History",
              ),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      onTap: () => {model.isRealTime = isRealTime},
    );
  }

  Widget _buildActionButton(
      {BuildContext context, Color color, String text, Function action}) {
    return FloatingActionButton(
      backgroundColor: color,
      child: Text(
        Translator.of(context).translate(text),
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      onPressed: () {
        action.call();
      },
    );
  }

  Widget _buildDateTimePicker(
      BuildContext context, HomeModel model, bool isStartDate) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      child: Column(
        children: <Widget>[
          Text(
            Translator.of(context)
                .translate(isStartDate ? "Start date" : "End date"),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 4.0,
            onPressed: () {
              DatePicker.showDateTimePicker(
                context,
                theme: DatePickerTheme(
                  containerHeight: 210.0,
                ),
                showTitleActions: true,
                onConfirm: (date) {
                  isStartDate
                      ? model.periodStartDate = date
                      : model.periodEndDate = date;
                },
                currentTime: DateTime.now(),
                locale: LocaleType.en,
              );
            },
            child: Container(
              alignment: Alignment.center,
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.date_range,
                              size: 18.0,
                              color: AppColors.primaryColor,
                            ),
                            Text(
                              (isStartDate
                                          ? model.periodStartDate
                                          : model.periodEndDate) !=
                                      null
                                  ? (isStartDate
                                          ? model.periodStartDate
                                          : model.periodEndDate)
                                      .toString()
                                      .split(".")[0]
                                  : "",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Text(
                    Translator.of(context).translate("Change"),
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                ],
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
