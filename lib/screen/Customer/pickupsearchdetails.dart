import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myscrapcollector/screen/Customer/precise.dart';
import 'package:myscrapcollector/screen/Customer/pickupresult.dart';
import 'package:myscrapcollector/screen/Customer/pickupsearchbox.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:myscrapcollector/widgets/custom_divider_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_html/flutter_html.dart';

class trackingdetails extends StatefulWidget {
  allbranchs todo;

  trackingdetails({Key key, @required this.todo}) : super(key: key);

  @override
  _BranchDetailsState createState() => _BranchDetailsState();
}

class _BranchDetailsState extends State<trackingdetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  String tid;
  List<track> t;
  @override
  Widget build(BuildContext context) {
    String id1 = widget.todo.id;
    print(id1);
    tid = id1;
    print("COO");
    print(tid);
    //List<int> sizeList = [7, 8, 9, 10];
    Color cyan = Color(0xff37d6ba);
    //List<Color> colorsList = [Colors.black, Colors.blue, Colors.red];

    int itemCount = 0;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: LightColor.red,
        title: Text('Pick Up ID - '+widget.todo.id),

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
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          'Pick Up Id - ' + widget.todo.id,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          'Customer Name - ' + widget.todo.userid,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          'Pick Up Date - ' + widget.todo.pickupdate,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          'Pick Up Time - ' + widget.todo.pickuptime,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 10),

                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          'Pickup Address - ' + widget.todo.address +' '+ widget.todo.city+' '+ widget.todo.pincode+' '+ widget.todo.state+' '+ widget.todo.country,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          'Employee Name - ' + widget.todo.username,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),


                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () async {
                              _fetchallbranch(widget.todo.id);
                              print("Printed");
                              SharedPreferences pf =
                                  await SharedPreferences.getInstance();
                              pf.setString("pickupid", id1);
                              print(tid);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => precise()));
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(LightColor.red,),),
                            child: Text("Show Item Details")),
                      ),
                      SizedBox(height: 50),
                      CustomDividerView(),

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

class track {
  final String pickupid;
  final String itemname;
  final String qty;
  final String price;

  track({this.pickupid, this.itemname, this.qty, this.price});

  factory track.fromJson(Map<String, dynamic> json) {
    return track(
      pickupid: json['pickupid'],
      itemname: json['itemname'],
      qty: json['qty'],
      price: json['price'],
    );
  }
}

Future<List<track>> _fetchallbranch(tid) async {
  // SharedPreferences pf = await SharedPreferences.getInstance();
  // dock = pf.getString("docket");

  final url = 'http://myscrapcollector.com/beta/api/tracking.php?pickupid=' + tid;

  var response = await http.get(url);
  print(url);
  print(response.body.toString());

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((job) => new track.fromJson(job)).toList();
  } else {
    throw Exception('Failed to load jobs from API');
  }
}
