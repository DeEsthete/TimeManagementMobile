import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_management_mobile/common/di_config.dart';
import 'package:time_management_mobile/common/enums/selected_duration.dart';
import 'package:time_management_mobile/common/enums/selected_screen.dart';
import 'package:time_management_mobile/models/deeds_count_model.dart';
import 'package:time_management_mobile/models/duration_model.dart';
import 'package:time_management_mobile/constant/color_consts.dart';
import 'package:time_management_mobile/dtos/deed_dto.dart';
import 'package:time_management_mobile/dtos/period_dto.dart';
import 'package:time_management_mobile/models/count_periods_model.dart';
import 'package:time_management_mobile/services/api/deed_service.dart';
import 'package:time_management_mobile/services/api/period_service.dart';
import 'package:time_management_mobile/utils/translator.dart';
import 'package:time_management_mobile/widgets/base/base_layout.dart';
import 'package:time_management_mobile/widgets/supporting/info_card.dart';

class StatisticScreen extends StatelessWidget {
  final PeriodService _periodService = getIt<PeriodService>();
  final DeedService _deedService = getIt<DeedService>();

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: "Statistic",
      selected: SelectedScreen.statistic,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildLastPeriod(),
            _buildCountPeriods(),
            _buildDeedPeriodsCount(),
            _buildDeedPercents(),
          ],
        ),
      ),
    );
  }

  Widget _buildLastPeriod() {
    return InfoCard(
      title: "Last period",
      child: FutureBuilder(
        future: _periodService.getLastPeriod(),
        builder: (context, snapshot) {
          PeriodDto period = snapshot.hasData ? snapshot.data : null;
          return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(12.0),
                child: period != null
                    ? FutureBuilder(
                        future: _deedService.getDeedById(period.deedId),
                        builder: (context, snapshot) {
                          DeedDto deed =
                              snapshot.hasData ? snapshot.data : null;
                          return Center(
                            child: Text(
                              snapshot.hasData ? deed.name : "",
                              style: TextStyle(fontSize: 22),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              Container(
                child: period != null
                    ? Text(
                        period.startDate.toString().split(".")[0] +
                            " - " +
                            period.endDate.toString().split(".")[0],
                        style: TextStyle(
                          color: AppColors.accentFontColor,
                        ),
                      )
                    : Container(),
              ),
              Container(
                margin: EdgeInsets.only(top: 4.0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColors.accentColor, width: 0.5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(period != null ? period.description : ""),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCountPeriods() {
    return InfoCard(
      title: "Count periods",
      child: ChangeNotifierProvider<CountPeriodsModel>(
        create: (context) => CountPeriodsModel(),
        child: Consumer<CountPeriodsModel>(
          builder: (context, model, child) {
            return Column(
              children: <Widget>[
                _buildDuration(context, model),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        model.count.toString(),
                        style: TextStyle(
                          fontSize: 42,
                          color: AppColors.primaryColor,
                        ),
                      ),
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

  Widget _buildDeedPercents() {
    return InfoCard(
      title: "Deed percent",
      child: ChangeNotifierProvider<DeedsCountModel>(
        create: (context) => DeedsCountModel(),
        child: Consumer<DeedsCountModel>(
          builder: (context, model, child) {
            if (model.deeds == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<Widget> deedsWidgets = [];
            for (var i = 0; i < model.deeds.length; i++) {
              deedsWidgets.add(
                _buildDeedPercent(
                  context,
                  model.deeds[i].name,
                  model.getDeedPercent(model.deeds[i].id).toString() + "%",
                ),
              );
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildDuration(context, model),
                Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: deedsWidgets,
                      ),
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

  Widget _buildDeedPeriodsCount() {
    return InfoCard(
      title: "Deeds periods count",
      child: ChangeNotifierProvider<DeedsCountModel>(
        create: (context) => DeedsCountModel(),
        child: Consumer<DeedsCountModel>(
          builder: (context, model, child) {
            if (model.deeds == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<Widget> deedsWidgets = [];
            for (var i = 0; i < model.deeds.length; i++) {
              deedsWidgets.add(
                _buildDeedPercent(
                  context,
                  model.deeds[i].name,
                  model.getDeedPeriodsCount(model.deeds[i].id).toString(),
                ),
              );
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildDuration(context, model),
                Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: deedsWidgets,
                      ),
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

  Widget _buildDuration(BuildContext context, DurationModel model) {
    return Container(
      color: AppColors.accentFontColor.withOpacity(0.12),
      child: Padding(
        padding: const EdgeInsets.only(top: 4.5, left: 8.0),
        child: Row(
          children: <Widget>[
            _buildDurationSegment(
              context: context,
              title: "Day",
              action: () => {model.setDuration(SelectedDuration.day)},
              isSelected: model.duration == SelectedDuration.day,
            ),
            _buildDurationSegment(
              context: context,
              title: "Week",
              action: () => {model.setDuration(SelectedDuration.week)},
              isSelected: model.duration == SelectedDuration.week,
            ),
            _buildDurationSegment(
              context: context,
              title: "Month",
              action: () => {model.setDuration(SelectedDuration.month)},
              isSelected: model.duration == SelectedDuration.month,
            ),
            _buildDurationSegment(
              context: context,
              title: "Year",
              action: () => {model.setDuration(SelectedDuration.year)},
              isSelected: model.duration == SelectedDuration.year,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationSegment(
      {BuildContext context, String title, Function action, bool isSelected}) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.backgroundColor : Colors.transparent,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(6.0),
            topLeft: Radius.circular(6.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: Text(
            Translator.of(context).translate(title),
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
      onTap: () => {action.call()},
    );
  }

  Widget _buildDeedPercent(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        width: 120,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryColor,
            width: 3.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 18),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              value,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
