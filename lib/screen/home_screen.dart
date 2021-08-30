import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:myscrapcollector/screen/Customer/notification.dart';
import 'package:myscrapcollector/screen/Customer/pricelist.dart';
import 'package:myscrapcollector/screen/pickup.dart';
import 'package:myscrapcollector/static/Contact_Us.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:myscrapcollector/widgets/AppDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'homepage/home_slider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeStateScreen createState() => _HomeStateScreen();
}


callNumber() async {
  const number = '+919870042911'; //set the number here
  bool res = await FlutterPhoneDirectCaller.callNumber(number);
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
            IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationPage()));
                }),
          ],
        ),
        drawer: AppDrawer(),
        body: new SliderPage(),
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
                        title: const Text('AlertDialog Title'),
                        content: const Text('AlertDialog description'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () async => callNumber(),
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Icon(Icons.call,color: Colors.red[200],),
                ),
                title: 'Call Us'),
            TabItem(icon: Icons.contact_phone, title: 'Contact Us'),
          ],
          initialActiveIndex: 0, //optional, default as 0

          onTap: (index) {
            if (index == 0) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            } else if (index == 1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PriceList()));
            } else if (index == 2) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => pickupForm()));
            } else if (index == 3) {

            } else if (index == 4) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Contact_Us()));
            }
          },
        ));
  }
}
