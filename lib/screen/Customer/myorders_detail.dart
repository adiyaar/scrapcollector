import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myscrapcollector/screen/Customer/moredetails.dart';
import 'package:myscrapcollector/screen/Customer/myorders.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_html/flutter_html.dart';

class MyOrderDetails extends StatefulWidget {
  myorders todo;

  MyOrderDetails({Key key, @required this.todo}) : super(key: key);

  @override
  _MyOrderDetailsState createState() => _MyOrderDetailsState();
}

class _MyOrderDetailsState extends State<MyOrderDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List jsonResponse = [];
  bool visible = false;
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String emailValue = prefs.getString('email');
    return emailValue;
  }

  Future<List<itemdetail>> fetchmore() async {
    SharedPreferences pf = await SharedPreferences.getInstance();
    String id = pf.getString("id");
    print(id);
    final url = 'http://myscrapcollector.com/beta/api/myorderitems.php';
    var data = ({'pickupid': widget.todo.id});
    var response = await http.post(Uri.parse(url), body: json.encode(data));

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new itemdetail.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
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
      appBar: AppBar(
        backgroundColor: LightColor.red,
        title: Text(widget.todo.address),

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
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          'Pickup Date - ' + widget.todo.pickupdate,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          'Pickup Time - ' + widget.todo.pickuptime,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          'Pickup Time - ' + widget.todo.pickuptime,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          'Address - ' +
                              widget.todo.address +
                              ', ' +
                              widget.todo.area +
                              ', ' +
                              widget.todo.city +
                              '-' +
                              widget.todo.pincode +
                              ', ' +
                              widget.todo.state,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          'Delivery At - ' + widget.todo.wedeliveryin,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: 500,
                        child: moredetails(
                          todo: widget.todo,
                        ),
                      )
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
