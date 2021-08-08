import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myscrapcollector/screen/homepage/home_header.dart';
import 'package:myscrapcollector/screen/homepage/home_pricelist.dart';
import 'package:myscrapcollector/screen/homepage/home_aboutus.dart';
import 'package:myscrapcollector/screen/homepage/home_joinus_view.dart';
import 'package:myscrapcollector/screen/homepage/home_offer_banner_view.dart';
import 'package:myscrapcollector/screen/homepage/home_vision_mission_banner_view.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:myscrapcollector/utils/ui_helper.dart';
import 'package:myscrapcollector/widgets/custom_divider_view.dart';

class home_below_SliderGrid extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          BestInSafetyViews(),
          Container(

            height: 485,
            child: SummerItems(),
          ),
          SizedBox(height:20.0),

          CustomDividerView(),
          joinusview(),




          //CustomDividerView(),
          //jainjinendraView(),
        ],
      ),
    );
  }
}

class SliderIndicator extends AnimatedWidget {
  final PageController pageController;
  final int indicatorCount;

  SliderIndicator({this.pageController, this.indicatorCount})
      : super(listenable: pageController);
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List<Widget>.generate(indicatorCount, buildIndicator));
  }

  Widget buildIndicator(int index) {
    final page = pageController.position.minScrollExtent == null
        ? pageController.initialPage
        : pageController.page;
    bool active = page.round() == index;
    print("build $index ${pageController.page}");
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        child: Center(
          child: Container(
              width: 20,
              height: 5,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10))),
        ),
      ),
    );
  }
}

class Job {
  final String url;

  Job({
    this.url,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      url: json['url'],
    );
  }
}

Swiper imageSlider(context, data) {
  return new Swiper(
    //autoplay: true,
    itemCount: data.length,
    itemBuilder: (BuildContext context, int index) {
      return new Image.network(
        data[index].url,
        fit: BoxFit.fitWidth,
        width: 300,
      );
    },

    viewportFraction: 0.4,

    scale: 0.5,
  );
}

class jainjinendraView extends StatelessWidget {
  const jainjinendraView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.all(15.0),
      height: 400.0,
      color: Colors.grey[200],
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Wealth Into\nWaste',
                style: Theme.of(context).textTheme.headline4.copyWith(
                      color: Colors.grey[400],
                      fontSize: 60.0,
                      letterSpacing: 0.2,
                      height: 1.0,
                    ),
              ),
              UIHelper.verticalSpaceLarge(),
              Text(
                'My Scrap Collector',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.grey),
              ),
              Text(
                ' ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.grey),
              ),
              UIHelper.verticalSpaceExtraLarge(),
              Row(
                children: <Widget>[
                  Container(
                    height: 1.0,
                    width: MediaQuery.of(context).size.width / 4,
                    color: Colors.grey,
                  ),
                ],
              )
            ],
          ),
          Positioned(
            left: 230.0,
            top: 140.0,
            child: Image.asset(
              'assets/hath.png',
              height: 100.0,
              width: 100.0,
            ),
          )
        ],
      ),
    );
  }
}
