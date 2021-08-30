import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:myscrapcollector/screen/Customer/All_blogs.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:myscrapcollector/widgets/custom_divider_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BranchDetails extends StatefulWidget {
  allbranch todo;

  BranchDetails({Key key, @required this.todo}) : super(key: key);

  @override
  _BranchDetailsState createState() => _BranchDetailsState();
}

class _BranchDetailsState extends State<BranchDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool visible = false;
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String emailValue = prefs.getString('email');
    return emailValue;
  }

  int itemid;
  int counter = 1;
  //final productprice;
  double finalprice;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //List<int> sizeList = [7, 8, 9, 10];
    Color cyan = Color(0xff37d6ba);
    //List<Color> colorsList = [Colors.black, Colors.blue, Colors.red];

    int itemCount = 0;
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: LightColor.yellowColor,
      appBar: AppBar(
        title: Text(widget.todo.name),

        // backgroundColor: LightColor.midnightBlue,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            child: Column(children: <Widget>[
              Expanded(
                child: Container(
                  //padding: EdgeInsets.only(left: 15, right: 15),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Container(
                        // padding: EdgeInsets.only(left: 15, right: 15),
                        height: 300.0,

                        child: Swiper(
                          autoplay: false,
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return new Image.network(
                              'http://myscrapcollector.com/beta/admin/images/blogss/' +
                                  widget.todo.img,
                              //fit: BoxFit.fitWidth,

                            );
                          },
                          viewportFraction: 1.0,
                          scale: 0,
                        ),
                      ),
                      // SizedBox(),

                      /*  Positioned.fill(
                        child: Image.network(
                          widget.todo.url,
                        ),
                      ),*/
                      SizedBox(height: 5),
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                          widget.todo.name,
                          style: TextStyle(
                              fontSize: 24,
                              color: LightColor.midnightBlue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      SizedBox(height: 10),

                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                          widget.todo.postedby,
                          style: TextStyle(
                              fontSize: 14, color: LightColor.midnightBlue),
                        ),
                      ),
                      SizedBox(height: 10),
                      Html(data:  widget.todo.description),

                    ],
                  ),
                ),
              ),
            ]),
          ))
        ],
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: LightColor.midnightBlue,
    ));
  }
}
