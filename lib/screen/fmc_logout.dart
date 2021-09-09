import 'package:myscrapcollector/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:myscrapcollector/screen/Login/Login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class logout extends StatefulWidget {
  logout({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _logoutState createState() => _logoutState();
}

class _logoutState extends State<logout> { // Wrapper Widget
  String email;

  Future userLogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //preferences.remove("email");
   // SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showAlert(context));
    return Container(

    );
  }

  void showAlert(BuildContext context) {
    userLogout();

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen())
    );



  }

}