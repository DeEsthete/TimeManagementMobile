import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:time_management_mobile/common/enums/selected_screen.dart';
import 'package:time_management_mobile/constant/color_consts.dart';
import 'package:time_management_mobile/dtos/schedule_period_dto.dart';
import 'package:time_management_mobile/models/schedule_create_model.dart';
import 'package:time_management_mobile/models/schedule_period_model.dart';
import 'package:time_management_mobile/utils/translator.dart';
import 'package:time_management_mobile/widgets/base/base_layout.dart';
import 'package:time_management_mobile/widgets/supporting/info_card.dart';
import 'package:intl/intl.dart';

class ScheduleCreateScreen extends StatelessWidget {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: "Create schedule",
      selected: SelectedScreen.schedule,
      body: ChangeNotifierProvider<ScheduleCreateModel>(
        create: (context) => ScheduleCreateModel(),
        child: Consumer<ScheduleCreateModel>(
          builder: (context, model, child) {
            return Column(
              children: <Widget>[
                _buildScheduleDatePicker(context, model),
                _buildAddPeriod(context, model),
                Expanded(
                  child: _buildPeriodsList(context),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text(
                        Translator.of(context).translate("Create"),
                      ),
                      onPressed: () => {
                        model.createSchedule(),
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildScheduleDatePicker(
      BuildContext context, ScheduleCreateModel model) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      child: Column(
        children: <Widget>[
          Text(
            Translator.of(context).translate("Schedule date"),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 4.0,
            onPressed: () {
              DatePicker.showDatePicker(
                context,
                theme: DatePickerTheme(
                  containerHeight: 210.0,
                ),
                showTitleActions: true,
                onConfirm: (date) {
                  model.scheduleDate = date;
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
                              model.scheduleDate.toString().split(" ")[0],
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
                      fontSize: 18.0,
                    ),
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

  Widget _buildAddPeriod(
      BuildContext context, ScheduleCreateModel scheduleModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, left: 8.0, right: 8.0),
      child: Container(
        width: double.infinity,
        child: RaisedButton(
          child: Text(
            Translator.of(context).translate("Add period"),
          ),
          onPressed: () => {
            showDialog(
              context: context,
              builder: (context) {
                return ChangeNotifierProvider<SchedulePeriodModel>(
                  create: (context) => SchedulePeriodModel(
                    descriptionController: textController,
                  ),
                  child: Consumer<SchedulePeriodModel>(
                    builder: (context, model, child) {
                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    Translator.of(context)
                                        .translate("Add period"),
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  child: DropdownButton(
                                    value: model.selectedDeed?.id,
                                    hint: Text(
                                      Translator.of(context).translate(
                                          "Change deed for current period"),
                                    ),
                                    items: scheduleModel.deeds
                                        .map(
                                          (e) => DropdownMenuItem(
                                            child: Text(e.name),
                                            value: e.id,
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) =>
                                        {model.selectDeed(value)},
                                  ),
                                ),
                                _buildTimePicker(context, model, true),
                                _buildTimePicker(context, model, false),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: TextFormField(
                                      minLines: 4,
                                      maxLines: 4,
                                      controller: model.descriptionController,
                                      decoration: InputDecoration(
                                        hintText: Translator.of(context)
                                            .translate("Period description"),
                                      ),
                                    ),
                                  ),
                                ),
                                RaisedButton(
                                  onPressed: () => {
                                    scheduleModel.addPeriod(model.getPeriod()),
                                    Navigator.pop(context),
                                  },
                                  child: Text(
                                    Translator.of(context)
                                        .translate("Create period"),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          },
        ),
      ),
    );
  }

  Widget _buildPeriodsList(BuildContext context) {
    var model = context.watch<ScheduleCreateModel>();
    return model.schedulePeriods != null
        ? model.schedulePeriods.isNotEmpty
            ? InfoCard(
                child: ListView.builder(
                  itemCount: model.schedulePeriods.length,
                  itemBuilder: (context, index) => PeriodItem(
                      index: index + 1, period: model.schedulePeriods[index]),
                ),
              )
            : Container(
                margin: EdgeInsets.only(top: 16.0),
                child: Text(
                  Translator.of(context).translate("Periods not found"),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget _buildTimePicker(
      BuildContext context, SchedulePeriodModel model, bool isStartDate) {
    String timeFormate = "";
    if ((isStartDate ? model.periodStartDate : model.periodEndDate) != null) {
      timeFormate = DateFormat("HH:mm")
          .format(isStartDate ? model.periodStartDate : model.periodEndDate);
    }
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
              DatePicker.showTimePicker(
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
                              timeFormate,
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

class PeriodItem extends StatefulWidget {
  final int index;
  final SchedulePeriodDto period;

  PeriodItem({Key key, @required this.index, @required this.period})
      : super(key: key);

  @override
  _PeriodItemState createState() => _PeriodItemState();
}

class _PeriodItemState extends State<PeriodItem> {
  final borderColor = AppColors.mainFontColor.withOpacity(0.2);

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    var model = context.watch<ScheduleCreateModel>();
    return FlatButton(
      padding: EdgeInsets.zero,
      onPressed: () => setState(() {
        isExpanded = !isExpanded;
      }),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: borderColor,
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Center(
                      child: Text(
                        widget.index.toString(),
                        style: TextStyle(
                          color: AppColors.accentFontColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            model.getDeed(widget.period.deedId).name,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4.0),
                            child: Text(
                              widget.period.startDate.toString().split(".")[0] +
                                  " - " +
                                  widget.period.endDate
                                      .toString()
                                      .split(".")[0],
                              style: TextStyle(
                                color: AppColors.accentFontColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red.withOpacity(0.8),
                      ),
                      onPressed: () => {model.deletePeriod(widget.period)},
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: isExpanded
                  ? Container(
                      margin: EdgeInsets.only(bottom: 2.0),
                      child: Text(
                        widget.period.description,
                        style: TextStyle(
                          color: AppColors.mainFontColor,
                        ),
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
