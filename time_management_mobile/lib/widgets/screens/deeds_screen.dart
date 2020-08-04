import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_management_mobile/common/enums/selected_screen.dart';
import 'package:time_management_mobile/constant/color_consts.dart';
import 'package:time_management_mobile/dtos/deed_dto.dart';
import 'package:time_management_mobile/models/deeds_model.dart';
import 'package:time_management_mobile/utils/translator.dart';
import 'package:time_management_mobile/widgets/base/base_layout.dart';
import 'package:time_management_mobile/widgets/supporting/info_card.dart';

class DeedsScreen extends StatelessWidget {
  final TextEditingController _filterController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: "Deeds",
      selected: SelectedScreen.deeds,
      body: ChangeNotifierProvider<DeedsModel>(
        create: (context) => DeedsModel(),
        child: Consumer<DeedsModel>(
          builder: (context, value, child) {
            return Column(
              children: <Widget>[
                _buildAddButton(context),
                _buildFilterWidget(context),
                Expanded(
                  child: _buildDeedsList(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    var model = context.watch<DeedsModel>();

    return Padding(
      padding: const EdgeInsets.only(top: 6.0, left: 8.0, right: 8.0),
      child: Container(
        width: double.infinity,
        child: RaisedButton(
          child: Text(
            Translator.of(context).translate("Add deed"),
          ),
          onPressed: () => {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    Translator.of(context).translate("Add deed"),
                  ),
                  content: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: Translator.of(context).translate("Name"),
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        Translator.of(context).translate("Create"),
                      ),
                      onPressed: () => {
                        model.createDeed(_nameController.text),
                        Navigator.pop(context),
                      },
                    ),
                  ],
                );
              },
            ),
          }, // TODO
        ),
      ),
    );
  }

  Widget _buildFilterWidget(BuildContext context) {
    var model = context.watch<DeedsModel>();
    return InfoCard(
      paddingBottom: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Text(Translator.of(context).translate("Archived?")),
                    Checkbox(
                      value: model.isArchive,
                      onChanged: (value) => {
                        model.isArchive = !model.isArchive,
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: Translator.of(context).translate("Deed name"),
                  ),
                  controller: _filterController,
                ),
              ),
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () => {
                    model.loadDeeds(filter: _filterController.text),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeedsList(BuildContext context) {
    var model = context.watch<DeedsModel>();
    return model.deeds != null
        ? model.deeds.isNotEmpty
            ? InfoCard(
                child: ListView.builder(
                  itemCount: model.deeds.length,
                  itemBuilder: (context, index) =>
                      _buildDeedItem(context, index + 1, model.deeds[index]),
                ),
              )
            : Container(
                margin: EdgeInsets.only(top: 16.0),
                child: Text(
                  Translator.of(context).translate("Deeds not found"),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget _buildDeedItem(BuildContext context, int index, DeedDto deed) {
    final borderColor = AppColors.mainFontColor.withOpacity(0.2);
    var model = context.watch<DeedsModel>();

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderColor,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
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
          ),
          Expanded(
            flex: 8,
            child: Center(
              child: Text(deed.name,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primaryColor,
                  )),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: IconButton(
                icon: Icon(
                  deed.isArchived ? Icons.unarchive : Icons.archive,
                  color: (deed.isArchived ? AppColors.primaryColor : Colors.red)
                      .withOpacity(0.8),
                ),
                onPressed: () => {
                  deed.isArchived
                      ? model.unarchiveDeed(deed.id)
                      : model.archiveDeed(deed.id)
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
