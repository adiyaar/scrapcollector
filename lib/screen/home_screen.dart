import 'package:flutter/material.dart';
import 'package:myscrapcollector/screen/Customer/notification.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:myscrapcollector/widgets/AppDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage/home_slider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeStateScreen createState() => _HomeStateScreen();
}

class _HomeStateScreen extends State<HomeScreen> {
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
  }

  static const routeName = "/";
  final String email;

  _HomeStateScreen({Key key, @required this.email});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("My Scrap Collector"),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.notifications, color: Colors.white,), onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => notification()));
          }),
        ],
      ),
      drawer: AppDrawer(),
      body: new SliderPage(),
    );
  }
}
