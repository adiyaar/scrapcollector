import 'package:flutter/material.dart';
import 'package:myscrapcollector/utils/app_colors.dart';
import 'package:myscrapcollector/utils/ui_helper.dart';
import 'package:myscrapcollector/widgets/responsive.dart';

class visionmissionBannerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isTabletDesktop = Responsive.isTabletDesktop(context);
    final cardWidth =
        MediaQuery.of(context).size.width / (isTabletDesktop ? 3.8 : 1.2);

    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.arrow_downward,
                color: swiggyOrange,
              ),
              UIHelper.horizontalSpaceExtraSmall(),
              Flexible(
                child: Text(
                  "Find Your Special Someone",
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        color: swiggyOrange,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              UIHelper.horizontalSpaceExtraSmall(),
              Icon(
                Icons.arrow_downward,
                color: swiggyOrange,
              ),
            ],
          ),
          UIHelper.verticalSpaceMedium(),
          LimitedBox(
            maxHeight: 220.0,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(right: 10.0),
                padding: const EdgeInsets.all(10.0),
                width: cardWidth,
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  border: Border.all(color: swiggyOrange, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Start Interacting',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                UIHelper.verticalSpaceExtraSmall(),
                                Text(
                                  'Various versions have evolved over the years, sometimes by accident, '
                                      'sometimes on purpose',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                          ),
                          UIHelper.verticalSpaceExtraSmall(),
                          TextButton(
                            child: Text(
                              'Call Us',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: darkOrange),
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    UIHelper.horizontalSpaceSmall(),
                    ClipOval(
                      child: Image.asset(
                        'assets/homecircle.png',
                        height: 90.0,
                        width: 90.0,
                      ),
                    )
                  ],
                ),
              ),

            ),

          )
        ],
      ),
    );
  }
}
