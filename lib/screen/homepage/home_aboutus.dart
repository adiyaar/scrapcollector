import 'package:flutter/material.dart';
import 'package:myscrapcollector/screen/Customer/service_list.dart';
import 'package:myscrapcollector/screen/Customer/whychooseus.dart';
import 'package:myscrapcollector/utils/app_colors.dart';
import 'package:myscrapcollector/utils/ui_helper.dart';
import 'package:myscrapcollector/widgets/responsive.dart';

class home_aboutus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isTabletDesktop = Responsive.isTabletDesktop(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Column(
        children: <Widget>[
          if (!isTabletDesktop) UIHelper.verticalSpaceLarge(),
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: InkWell(
                  child: Container(
                    height: 150.0,
                    color: jainvivhapink,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: FractionallySizedBox(
                            widthFactor: 0.7,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Why Choose Us?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 45.0,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          color: darkpink,
                          child: Row(
                            children: <Widget>[
                              Text(
                                'View all',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        color: Colors.white, fontSize: 18.0),
                              ),
                              UIHelper.horizontalSpaceSmall(),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 18.0,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: isTabletDesktop
                      ? () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Whychooseus()));
                        }
                      : () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Whychooseus()));
                        },
                ),
              ),
              Positioned(
                top: 0.0,
                right: 0.0,
                child: ClipOval(
                  child: Image.asset(
                    'assets/jlogo.png',
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          UIHelper.verticalSpaceMedium(),
        ],
      ),
    );
  }
}
