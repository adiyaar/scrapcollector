import 'package:flutter/material.dart';
import 'package:myscrapcollector/screen/Login/Login_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:myscrapcollector/widgets/bezierContainer.dart';

import 'otpverification.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<RegistrationScreen> {
  @override
  void initState() {
    super.initState();
    getentity();
  }

  // Boolean variable for CircularProgressIndicator.
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool visible = false;
  static const Color midnightBlue = const Color.fromRGBO(1, 4, 99, 1);
  // Getting value from TextField widget.
  String selectedvalue;
  final fnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();

  final addressController = TextEditingController();
  final areaController = TextEditingController();
  final pincodeController = TextEditingController();
  final entitynameController = TextEditingController();
  final entityvalueController = TextEditingController();
  List pickuparea = [];
  Future getentity() async {
    var response = await http.post(
      'http://myscrapcollector.com/beta/api/api.php?get_entityvalue',
    );
    var jsonbody = response.body;
    var jsondata = json.decode(jsonbody);
    print(jsondata);
    setState(() {
      pickuparea = jsondata;
    });
  }

  Future userRegistration() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String firstname = fnameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String mobile = mobileController.text;
    String state = stateController.text;
    String city = cityController.text;

    String address = addressController.text;
    String area = areaController.text;
    String pincode = pincodeController.text;
    String entityname = entitynameController.text;
    // String entityvalue = entityvalueController.text;

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (mobile.length != 10) {
      showInSnackBar("Invalid Mobile No");
      //showToast('Invalid Mobile No', gravity: Toast.BOTTOM, duration: 3);
    } else if (firstname.length == 0 ||
        password.length == 0 ||
        mobile.length == 0) {
      showInSnackBar("Field Should not be empty");
    } else if (!regex.hasMatch(email)) {
      showInSnackBar("Enter Valid Email");
    } else {
      // SERVER API URL
      var url = 'http://myscrapcollector.com/beta/api/register_user.php';

      // Store all data with Param Name.
      var data = {
        'firstname': firstname,
        'email': email,
        'password': password,
        'mobile': mobile,
        'state': state,
        'city': city,
        'address': address,
        'pincode': pincode,
        'area': area,
        'entityname': entityname,
        'entityvalue': selectedvalue,
      };
      print(data);
      // Starting Web API Call.
      var response = await http.post(url, body: json.encode(data));

      // Getting Server response into variable.
      var message = jsonDecode(response.body);

      // If Web call Success than Hide the CircularProgressIndicator.
      if (response.statusCode == 200) {
        setState(() {
          visible = false;
        });
      }
      showInSnackBar(message);
      // fnameController.clear();
      // mobileController.clear();
      // emailController.clear();
      // passwordController.clear();
      // stateController.clear();
      // cityController.clear();
      // addressController.clear();
      // areaController.clear();
      // pincodeController.clear();
      // entitynameController.clear();
      // entityvalueController.clear();
      // Showing Alert Dialog with Response JSON Message.

    }
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Colors.red, fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Center(
      child: Column(
        children: <Widget>[
          Container(height: 100.0, child: Image.asset('assets/1stscreen.png')),
        ],
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Text(
              "Full Name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ]),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
            controller: fnameController,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          ),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            /*SizedBox(
              width: 10,
            ),*/
            Text(
              "Email Id ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              width: 120,
            ),
            Text(
              "Password",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Container(
              width: 180.0,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 180.0,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password ';
                  }
                  return null;
                },
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true),
              ),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Text(
              "Mobile",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ]),
          TextFormField(
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your mobile number';
              }
              return null;
            },
            controller: mobileController,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          ),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Text(
              "Address",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ]),
          TextField(
            keyboardType: TextInputType.number,
            controller: addressController,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          ),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Text(
              "City",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              width: 160,
            ),
            Text(
              "Pincode",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Container(
              width: 180.0,
              child: TextField(
                controller: cityController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 180.0,
              child: TextField(
                controller: pincodeController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true),
              ),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Text(
              "Area",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              width: 160,
            ),
            Text(
              "State",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Container(
              width: 180.0,
              child: TextField(
                controller: areaController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 180.0,
              child: TextField(
                controller: stateController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true),
              ),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Text(
              "Entity Name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              width: 100,
            ),
            Text(
              "Entity Value",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Container(
              width: 180.0,
              child: TextField(
                controller: entitynameController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 180.0,
              child: DropdownButton(
                value: selectedvalue,
                hint: Text("Entity Value"),
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
          ]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: InkWell(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                userRegistration();

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Verify(mobileController.text)));
                              } else {
                                print("hh");
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.grey.shade200,
                                        offset: Offset(2, 4),
                                        blurRadius: 5,
                                        spreadRadius: 2)
                                  ],
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [Colors.red, Colors.red])),
                              child: Text(
                                'Register Now',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))),
                    // SizedBox(height: height * .14),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
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
