import 'dart:convert';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:myscrapcollector/screen/Customer/pricelist.dart';
import 'package:myscrapcollector/screen/home_screen.dart';

import 'package:myscrapcollector/static/Contact_Us.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:myscrapcollector/widgets/AppDrawer.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'Customer/account_details.dart';

class pickupForm extends StatefulWidget {
  @override
  _pickupFormState createState() => _pickupFormState();
}

class _pickupFormState extends State<pickupForm> {
  String user_id;
  String custid;
  List pickuparea = [];
  List pickuptime = [];
  String selectedvalue;
  String selectedtime;
  bool checked = true;
  String address1;
  String area1;
  String pincode1;
  String city1;
  String state1;

  TextEditingController address = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController customerarea = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController state = TextEditingController();
  List alltotal;

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

  Future<List<Account>> fetchalldetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id = prefs.getString('id');
    dynamic token = user_id;
    print(token);
    var data = {'userid': token};
    var url = 'http://myscrapcollector.com/beta/api/accountdetails.php';

    var response = await http.post(url, body: json.encode(data));
    alltotal = json.decode(response.body);
    List<Account> userdetails =
        alltotal.map((item) => new Account.fromJson(item)).toList();

    return userdetails;
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
      'userid': user_id,
      // 'address': address.text,
      'address': address1,
      'pickupdate': date.text,
      // 'area': area.text,
      'area': area1,
      'pickuptime': selectedtime,
      'pickuparea': selectedvalue,
      // 'city': city.text,
      'city': city1,
      // 'state': state.text,
      'state': state1,
      // 'pincode': pincode.text
      'pincode': pincode1
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
    fetchalldetails();
  }

  accountinfo(context, data) {
    return Container(
      height: 380,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, index) {
          address1 = data[index].address;
          area1 = data[index].area;
          pincode1 = data[index].pincode;
          city1 = data[index].city;
          state1 = data[index].state;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Address",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 35,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: TextFormField(
                    autofocus: false,
                    initialValue: data[index].address,
                    onChanged: (text) {
                      print(text);

                      address1 = address.text;

                      setState(() {});
                    },
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Area",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 35,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: TextFormField(
                    autofocus: false,

                    initialValue: data[index].area,
                    onChanged: (text) {
                      area1 = text;
                      setState(() {});
                    },
                    //controller: emailController,
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "City",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 35,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: TextFormField(
                    autofocus: false,
                    // controller: address,
                    initialValue: data[index].city,
                    onChanged: (text) {
                      city1 = text;
                      setState(() {});
                    },
                    //controller: emailController,
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Pincode",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 35,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: TextFormField(
                    autofocus: false,

                    initialValue: data[index].pincode,
                    onChanged: (text) {
                      pincode1 = text;
                      setState(() {});
                    },
                    //controller: emailController,
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "State",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 35,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: TextFormField(
                    autofocus: false,

                    initialValue: data[index].state,
                    onChanged: (text) {
                      state1 = text;
                      setState(() {});
                    },
                    //controller: emailController,
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
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
                  // await callNumber();
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Enquiry Now'),
                      content:
                          const Text('Are you sure you want to call us ? '),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('No',
                              style: TextStyle(color: Colors.red)),
                        ),
                        TextButton(
                          onPressed: () async => callNumber(),
                          child: const Text('Yes',
                              style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: width / 1.1,
                child: Text(
                  "Pickup Area",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: DropdownButton(
                  value: selectedvalue,
                  hint: Text("Pickup Area"),
                  items: pickuparea.map(
                    (list) {
                      return DropdownMenuItem(
                          child: SizedBox(
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
              SizedBox(height: 15),
              Container(
                width: width / 1.1,
                child: Text(
                  "Date",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                //color: Colors.grey[300],
                height: 35,
                child: DateTimeField(
                  controller: date,
                  format: format,
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        firstDate: DateTime.now().subtract(Duration(days: 0)),
                        lastDate: DateTime(2100),
                        context: context,
                        initialDate: currentValue ?? DateTime.now(),
                        builder: (BuildContext context, Widget child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: ColorScheme.light().copyWith(
                                primary: Colors.red,
                              ),
                            ),
                            child: child,
                          );
                        });
                  },
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: width / 1.1,
                child: Text(
                  "Pickup Time",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: DropdownButton(
                  value: selectedtime,
                  hint: Text("Select Time"),
                  items: pickuptime.map(
                    (list) {
                      return DropdownMenuItem(
                          child: SizedBox(
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
                height: 10.0,
              ),
              //CustomDividerView(),

              // if (checked == true)
              Column(
                children: [
                  FutureBuilder<List<Account>>(
                    future: fetchalldetails(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Account> data = snapshot.data;
                        if (snapshot.data.length == 0) {
                          return Container(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 80));
                          //child: Image.asset("assets/cart.png"));
                        }

                        return accountinfo(context, data);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            LightColor.midnightBlue),
                      ));
                    },
                  ),
                ],
              ),

              SizedBox(
                height: 20.0,
              ),

              Center(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)),
                  onPressed: () {
                    usermsg();
                    //showInSnackBar('Thank You.. Will get back to you..!!');
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text("Submit Pickup Request",
                      style: TextStyle(fontSize: 18)),
                ),
              ),

              SizedBox(height: 25),
            ],
          ),
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
