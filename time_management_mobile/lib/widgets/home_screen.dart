import 'package:flutter/cupertino.dart';
import 'package:time_management_mobile/common/selected_screen.dart';
import 'package:time_management_mobile/widgets/base/base_layout.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: "Home",
      selected: SelectedScreen.home,
      body: Container(),
    );
  }
}
