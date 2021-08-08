import 'package:flutter/material.dart';
import 'package:myscrapcollector/screen/homepage/home_below_SliderGrid.dart';
import 'package:myscrapcollector/screen/homepage/home_joinus_view.dart';
import 'package:myscrapcollector/screen/homepage/home_vision_mission_banner_view.dart';
import 'package:myscrapcollector/static/aboutus_detail.dart';
import 'package:myscrapcollector/widgets/AppDrawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:myscrapcollector/widgets/custom_divider_view.dart';


class About_Us_Screen extends StatefulWidget {
  @override
  _About_UsScreen createState() => _About_UsScreen();
}

class _About_UsScreen extends State<About_Us_Screen> {


  static const routeName = "/";


// Receiving Email using Constructor.

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("About Us"),

      ),
      drawer: AppDrawer(),
      body: Refund(),
    );
  }
}

class StaticPage {

  final String content;

  StaticPage({this.content});

  factory StaticPage.fromJson(Map<String, dynamic> json) {
    return StaticPage(

      content:json['content'],
    );
  }
}
class Refund extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StaticPage>>(
      future: _fetchStaticPage(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<StaticPage> data = snapshot.data;
          return imageSlider(context, data);

        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<StaticPage>> _fetchStaticPage() async {
    final jobsListAPIUrl = 'http://myscrapcollector.com/beta/api/api.php?get_aboutus';
    final response = await http.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new StaticPage.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

imageSlider(context, data) {
  return Container(


    child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      itemBuilder: (context, index) {

        return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               Image.asset("assets/aboutus.jpeg"),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Html(
                  data: data[index].content,
                ),
              ),





              CustomDividerView(),
              joinusview(),
              CustomDividerView(),
              jainjinendraView(),

            ]  );
      },

    ),


  );

}



