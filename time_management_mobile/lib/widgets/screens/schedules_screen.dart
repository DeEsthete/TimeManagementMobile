import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_management_mobile/common/enums/selected_screen.dart';
import 'package:time_management_mobile/constant/color_consts.dart';
import 'package:time_management_mobile/dtos/period_dto.dart';
import 'package:time_management_mobile/dtos/schedule_dto.dart';
import 'package:time_management_mobile/models/schedules_model.dart';
import 'package:time_management_mobile/utils/translator.dart';
import 'package:time_management_mobile/widgets/base/base_layout.dart';
import 'package:time_management_mobile/widgets/supporting/info_card.dart';

class SchedulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: "Schedule",
      selected: SelectedScreen.schedule,
      body: ChangeNotifierProvider<SchedulesModel>(
        create: (context) => SchedulesModel(),
        child: Consumer<SchedulesModel>(
          builder: (context, value, child) {
            return Column(
              children: <Widget>[
                // TODO: Добавление расписания
                _buildTodaySchedule(context),
                Expanded(
                  child: _buildSchedulesList(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTodaySchedule(BuildContext context) {
    var model = context.watch<SchedulesModel>();
    return model.todaySchedule != null
        ? InfoCard(
            isRounded: false,
            child: ScheduleItem(schedule: model.todaySchedule),
          )
        : Container();
  }

  Widget _buildSchedulesList(BuildContext context) {
    var model = context.watch<SchedulesModel>();
    return InfoCard(
      child: Column(
        children: <Widget>[
          _buildNavigation(context),
          Expanded(
            child: model.schedules != null
                ? model.schedules.isNotEmpty
                    ? ListView.builder(
                        itemCount: model.schedules.length,
                        itemBuilder: (context, index) => ScheduleItem(
                          index: index,
                          schedule: model.schedules[index],
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(top: 28),
                        child: Text(
                          Translator.of(context)
                              .translate("Schedules not found"),
                          style: TextStyle(
                            fontSize: 22,
                            color: AppColors.mainFontColor.withOpacity(0.6),
                          ),
                        ),
                      )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          )
        ],
      ),
    );
  }

  Widget _buildNavigation(BuildContext context) {
    var model = context.watch<SchedulesModel>();
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

  Widget _buildNavigationSegment(
      BuildContext context, SchedulesModel model, bool isHistory) {
    return GestureDetector(
      child: Container(
        color: model.isHistory == isHistory
            ? Colors.transparent
            : Colors.black.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(5.5),
          child: Center(
            child: Text(
              Translator.of(context).translate(
                isHistory ? "Future" : "History",
              ),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      onTap: () => {model.isHistory = isHistory},
    );
  }
}

class ScheduleItem extends StatefulWidget {
  final int index;
  final ScheduleDto schedule;

  ScheduleItem({this.index, @required this.schedule});

  @override
  _ScheduleItemState createState() => _ScheduleItemState();
}

class _ScheduleItemState extends State<ScheduleItem> {
  final borderColor = AppColors.mainFontColor.withOpacity(0.2);

  bool isExpanded;

  @override
  Widget build(BuildContext context) {
    var model = context.watch<SchedulesModel>();
    var index = widget.index;
    var schedule = widget.schedule;

    DateTime scheduleDate = new DateTime(
      schedule.scheduleDate.year,
      schedule.scheduleDate.month,
      schedule.scheduleDate.day,
    );

    DateTime now = new DateTime.now();
    now = new DateTime(
      now.year,
      now.month,
      now.day,
    );

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
                index != null
                    ? Expanded(
                        flex: 1,
                        child: Container(
                          child: Center(
                            child: Text(
                              index.toString(),
                              style: TextStyle(
                                color: AppColors.accentFontColor,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        scheduleDate != now
                            ? scheduleDate.toString().split(".")[0]
                            : Translator.of(context).translate("Today"),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                    ),
                  ),
                )
              ],
            ),
            Container(
              child: isExpanded
                  ? Container(
                      child: FutureBuilder(
                        future: model.scheduleService
                            .getPeriodsByScheduleId(schedule.id),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) => _buildPeriodItem(
                                context, index, snapshot.data[index]),
                          );
                        },
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodItem(BuildContext context, int index, PeriodDto period) {
    var model = context.watch<SchedulesModel>();
    return Container(
      child: Row(
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
            flex: 9,
            child: Container(
              decoration: BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      model.getDeed(period.deedId).name,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4.0),
                      child: Text(
                        period.startDate.toString().split(".")[0] +
                            " - " +
                            period.endDate.toString().split(".")[0],
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
        ],
      ),
    );
  }
}
