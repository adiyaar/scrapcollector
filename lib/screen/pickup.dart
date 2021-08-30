import 'dart:convert';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:myscrapcollector/screen/Customer/pricelist.dart';
import 'package:myscrapcollector/screen/home_screen.dart';

import 'package:myscrapcollector/screen/homepage/home_joinus_view.dart';
import 'package:myscrapcollector/screen/homepage/home_vision_mission_banner_view.dart';
import 'package:myscrapcollector/static/Contact_Us.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:myscrapcollector/widgets/AppDrawer.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:myscrapcollector/widgets/custom_divider_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class pickupForm extends StatefulWidget {
  @override
  _pickupFormState createState() => _pickupFormState();
}

class _pickupFormState extends State<pickupForm> {
  String customerid;
  String custid;
  List pickuparea = [];
  List pickuptime = [];
  String selectedvalue;
  bool checked = false;
  String selectedtime;

  TextEditingController address = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController customerarea = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController state = TextEditingController();

  void prefetchdata() async {
    SharedPreferences pf = await SharedPreferences.getInstance();

    customerid = pf.getString('id');
    print(customerid);
    print("MMME");
    setState(() {
      custid = customerid;
    });
  }

  Future getallvalue() async {
    var response = await http.post(
      'http://myscrapcollector.com/beta/api/api.php?get_area',
    );
    var jsonbody = response.body;
    var jsondata = json.decode(jsonbody);
    print(jsondata);
    setState(() {
      pickuparea = jsondata;
    });
  }

  Future getTime() async {
    var response = await http.post(
      'http://myscrapcollector.com/beta/api/api.php?get_timeslot',
    );
    var jsonbody = response.body;
    var jsondata = json.decode(jsonbody);
    print(jsondata);
    setState(() {
      pickuptime = jsondata;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _callNumber() async {
    const number = '+97444320567'; //set the number here
    bool res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  Future usermsg() async {
    // SERVER API URL
    var url = 'http://myscrapcollector.com/beta/api/pickup.php';

    // Store all data with Param Name.
    var data = {
      'userid': customerid,
      'address': address.text,
      'pickupdate': date.text,
      'area': area.text,
      'pickuptime': selectedtime,
      'pickuparea': selectedvalue,
      'city': city.text,
      'state': state.text,
      'pincode': pincode.text
    };
    print(data);

    var response = await http.post(url, body: json.encode(data));
    if (response.statusCode == 200) {
      showInSnackBar("Thank You");
    }
  }

  @override
  void initState() {
    super.initState();
    getallvalue();
    getTime();
    prefetchdata();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final format = DateFormat("yyyy-MM-dd");

    return Scaffold(
      appBar: AppBar(
        title: Text("Pickup Form"),
      ),
      drawer: AppDrawer(),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: LightColor.red,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.done_all, title: 'Price List'),
          TabItem(icon: Icons.directions_bus, title: 'Pick Up'),
          TabItem(
              icon: InkWell(
                onTap: () async {
                  await _callNumber();
                },
                child: Icon(
                  Icons.call,
                  color: Colors.red[200],
                ),
              ),
              title: 'Call Us'),
          TabItem(icon: Icons.contact_phone, title: 'Contact Us'),
        ],
        initialActiveIndex: 2, //optional, default as 0

        onTap: (index) {
          if (index == 0) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          } else if (index == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PriceList()));
          } else if (index == 2) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => pickupForm()));
          } else if (index == 3) {
          } else if (index == 4) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Contact_Us()));
          }
        },
      ),
      body: new SingleChildScrollView(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: width / 2.2,
                        child: Text(
                          "Address",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ])),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                left: 15,
              ),
              height: 70,
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    color: Colors.grey[300],
                    height: 50,
                    child: TextFormField(
                      controller: address,
                      decoration:
                          InputDecoration(border: UnderlineInputBorder()),
                    ),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: width / 2,
                        child: Text(
                          "Date",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      Container(
                        width: width / 2.2,
                        child: Text(
                          "Area",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ])),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: checked,
                  onChanged: (bool value) {
                    setState(() {
                      checked = value;
                    });
                  },
                ),
                Text("Additional Info")
              ],
            ),
            if (checked == true) 
              Container(child: Text("RaM")),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                left: 15,
              ),
              height: 70,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    color: Colors.grey[300],
                    height: 50,
                    child: DateTimeField(
                      controller: date,
                      format: format,
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    color: Colors.grey[300],
                    height: 50,
                    child: TextFormField(
                      controller: area,
                      decoration:
                          InputDecoration(border: UnderlineInputBorder()),
                    ),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: width / 2,
                        child: Text(
                          "Pickup Time",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      Container(
                        width: width / 2.2,
                        child: Text(
                          "City",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ])),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                left: 15,
              ),
              height: 70,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: DropdownButton(
                      value: selectedtime,
                      hint: Text("Select Time"),
                      items: pickuptime.map(
                        (list) {
                          return DropdownMenuItem(
                              child: SizedBox(
                                width: 150,
                                child: Text(list['title']),
                              ),
                              value: list['title']
                              // value: widget.todo.itemproductgroupid,
                              );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedtime = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    color: Colors.grey[300],
                    height: 50,
                    child: TextFormField(
                      controller: city,
                      decoration:
                          InputDecoration(border: UnderlineInputBorder()),
                    ),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: width / 2,
                        child: Text(
                          "Pickup Area",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      Container(
                        width: width / 2.2,
                        child: Text(
                          "Pincode",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ])),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                left: 15,
              ),
              height: 70,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: DropdownButton(
                      value: selectedvalue,
                      hint: Text("Select Area"),
                      items: pickuparea.map(
                        (list) {
                          return DropdownMenuItem(
                              child: SizedBox(
                                width: 150,
                                child: Text(list['title']),
                              ),
                              value: list['title']
                              // value: widget.todo.itemproductgroupid,
                              );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedvalue = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    color: Colors.grey[300],
                    height: 50,
                    child: TextFormField(
                      controller: pincode,
                      decoration:
                          InputDecoration(border: UnderlineInputBorder()),
                    ),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: width / 2.2,
                        child: Text(
                          "State",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ])),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                left: 15,
              ),
              height: 70,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    color: Colors.grey[300],
                    height: 50,
                    child: TextFormField(
                      controller: state,
                      decoration:
                          InputDecoration(border: UnderlineInputBorder()),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.red)),
                onPressed: () {
                  usermsg();
                },
                color: Colors.red,
                textColor: Colors.white,
                child: Text("Send Message", style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
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

class pickupArea {
  String id;
  String title;

  pickupArea({this.id, this.title});

  pickupArea.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
