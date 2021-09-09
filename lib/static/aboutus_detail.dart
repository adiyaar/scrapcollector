import 'package:flutter/material.dart';
import 'package:myscrapcollector/screen/Customer/service_list.dart';
import 'package:myscrapcollector/utils/app_colors.dart';
import 'package:myscrapcollector/utils/ui_helper.dart';
import 'package:myscrapcollector/widgets/responsive.dart';

class aboutus_detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isTabletDesktop = Responsive.isTabletDesktop(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Column(
        children: <Widget>[
          if (!isTabletDesktop)

          if (!isTabletDesktop) UIHelper.verticalSpaceLarge(),

          UIHelper.verticalSpaceMedium(),
        ],
      ),
    );
  }
}
