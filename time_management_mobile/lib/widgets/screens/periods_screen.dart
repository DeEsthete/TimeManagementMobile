import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:time_management_mobile/common/selected_screen.dart';
import 'package:time_management_mobile/constant/color_consts.dart';
import 'package:time_management_mobile/dtos/period_dto.dart';
import 'package:time_management_mobile/models/periods_model.dart';
import 'package:time_management_mobile/utils/translator.dart';
import 'package:time_management_mobile/widgets/base/base_layout.dart';
import 'package:time_management_mobile/widgets/supporting/info_card.dart';

class PeriodsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: "Periods",
      selected: SelectedScreen.periods,
      body: ChangeNotifierProvider<PeriodsModel>(
        create: (context) => PeriodsModel(),
        child: Consumer<PeriodsModel>(
          builder: (context, value, child) {
            return Column(
              children: <Widget>[
                _buildFilter(context),
                Expanded(
                  child: _buildPeriodsList(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilter(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildDateTimePicker(context, true),
          _buildDateTimePicker(context, false),
        ],
      ),
    );
  }

  Widget _buildPeriodsList(BuildContext context) {
    var model = context.watch<PeriodsModel>();
    return model.periods != null
        ? model.periods.isNotEmpty
            ? InfoCard(
                child: ListView.builder(
                  itemCount: model.periods.length,
                  itemBuilder: (context, index) => PeriodItem(
                      index: index + 1, period: model.periods[index]),
                ),
              )
            : Container(
                margin: EdgeInsets.only(top: 16.0),
                child: Text(
                  Translator.of(context)
                      .translate("Periods by this date range not found"),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget _buildDateTimePicker(BuildContext context, bool isStartDate) {
    var model = context.watch<PeriodsModel>();
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
                  isStartDate ? model.from = date : model.to = date;
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
                              (isStartDate ? model.from : model.to) != null
                                  ? (isStartDate ? model.from : model.to)
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

class PeriodItem extends StatefulWidget {
  final int index;
  final PeriodDto period;

  PeriodItem({Key key, @required this.index, @required this.period})
      : super(key: key);

  @override
  _PeriodItemState createState() => _PeriodItemState();
}

class _PeriodItemState extends State<PeriodItem> {
  final borderColor = AppColors.mainFontColor.withOpacity(0.2);
  final accentColor = AppColors.mainFontColor.withOpacity(0.6);

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    var model = context.watch<PeriodsModel>();
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
                          color: accentColor,
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
                                color: accentColor,
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
                      onPressed: () => {model.deletePeriod(widget.period.id)},
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
