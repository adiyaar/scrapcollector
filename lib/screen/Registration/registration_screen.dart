import 'package:flutter/material.dart';
import 'package:myscrapcollector/screen/Login/Login_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:myscrapcollector/widgets/bezierContainer.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<RegistrationScreen> {
  // Boolean variable for CircularProgressIndicator.
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool visible = false;
  static const Color midnightBlue = const Color.fromRGBO(1, 4, 99, 1);
  // Getting value from TextField widget.
  final fnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileController = TextEditingController();
  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();

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
    String country = countryController.text;
    String state = stateController.text;
    String city = cityController.text;
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (mobile.length != 10) {
      showInSnackBar("Invalid Mobile No");
      //showToast('Invalid Mobile No', gravity: Toast.BOTTOM, duration: 3);
    } else if (firstname.length == 0 ||
        password.length == 0 ||
        country.length == 0 ||
        state.length == 0 ||
        city.length == 0) {
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
        'country': country,
        'state': state,
        'city': city,
      };

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
      fnameController.clear();
      mobileController.clear();
      emailController.clear();
      countryController.clear();
      passwordController.clear();
      stateController.clear();
      cityController.clear();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Text(
            "Full Name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ]),
        TextField(
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
            child: TextField(
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
            child: TextField(
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
        TextField(
          keyboardType: TextInputType.number,
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
            "Country: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            width: 120,
          ),
          Text(
            "State:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),

        ]),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Container(
            width: 180.0,
            child: TextField(
              controller: countryController,
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
          /*SizedBox(
            width: 10,
          ),*/
          Text(
            "City / Nearest City: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ]),

        TextField(
          controller: cityController,
          decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true),
        ),

      ],
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
                      child: Button(
                        onClick: userRegistration,
                        btnText: "Registration",
                      ),
                    ),
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

class Button extends StatelessWidget {
  var btnText = "";
  var onClick;

  Button({this.btnText, this.onClick});
  Color yellowColors = Colors.red;
  static const Color midnightBlue = const Color(0xfff3f3f4);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onClick,
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
                  colors: [yellowColors, Colors.red])),
          child: InkWell(
            child: Text(
              'Register Now',
              style: TextStyle(
                  fontSize: 20,
                  color: midnightBlue,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
