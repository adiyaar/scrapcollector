import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myscrapcollector/screen/Customer/All_blogs.dart';
import 'package:myscrapcollector/screen/Customer/account_details.dart';
import 'package:myscrapcollector/screen/Customer/client.dart';
import 'package:myscrapcollector/screen/Customer/myorders.dart';
import 'package:myscrapcollector/screen/Customer/notification.dart';
import 'package:myscrapcollector/screen/Customer/photogallery.dart';
import 'package:myscrapcollector/screen/Customer/pricelist.dart';
import 'package:myscrapcollector/screen/Customer/service_list.dart';
import 'package:myscrapcollector/screen/Customer/testimonials.dart';
import 'package:myscrapcollector/screen/Customer/pickupsearchbox.dart';
import 'package:myscrapcollector/screen/Customer/whychooseus.dart';
import 'package:myscrapcollector/screen/fmc_logout.dart';
import 'package:myscrapcollector/screen/home_screen.dart';
import 'package:myscrapcollector/static/About_Us.dart';
import 'package:myscrapcollector/static/Contact_Us.dart';
import 'package:myscrapcollector/static/Privacy_Policy.dart';
import 'package:myscrapcollector/static/Terms_Condition.dart';
import 'package:myscrapcollector/static/faq_screen.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:myscrapcollector/widgets/custom_divider_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  //final String email;
  @override
  static const Color red = Colors.red;

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var username;
  var id;

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Return String
    setState(() {
      username = prefs.getString("email");
      id = prefs.getString('userid');
    });
  }


  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String useridValue = prefs.getString('id');
    print(useridValue);
    //return useridValue;
    setState(() {
      // username = prefs.getString("email");
      id = prefs.getString('id');
    });
  }


  @override
  void initState() {
    super.initState();
    getStringValuesSF();
    getStringValues();

  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
        child: ListView(
      children: <Widget>[

        Container(
          color: Colors.white,

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image(
                  image: AssetImage('assets/1stscreen.png'),

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${username}',
                  style:
                  TextStyle(fontSize: 15.0, color: Colors.black.withOpacity(1.0)),
                ),
              ),

              SizedBox(height: 10.0,),
            ],
          ),
        ),

        CustomDividerView(),

//        UserAccountsDrawerHeader(
//          decoration: BoxDecoration(color: AppDrawer.red),
//          accountName: Text(
//            '${username}',
//            style:
//                TextStyle(fontSize: 15.0, color: Colors.white.withOpacity(1.0)),
//          ),
//          currentAccountPicture: CircleAvatar(
//            backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
//                ? new Color(0xffF72804)
//                : Colors.white,
//            child: Icon(Icons.person,
//                size: 50, color: Colors.black),
//          ),
//        ),


        ListTile(
          leading: Icon(
            Icons.home,
            color: Colors.black,
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          title: Text('Home',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),



        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: Icon(
            Icons.message,
            color: Colors.black,
          ),
          title: Text('About Us',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => About_Us_Screen()));},
        ),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: Icon(
            Icons.security,
            color: Colors.black,
          ),
          title: Text('Services ',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ServiceList()));
          },
        ),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: Icon(
            Icons.security,
            color: Colors.black,
          ),
          title: Text('Why Choose Us ',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Whychooseus()));
          },
        ),



        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: new  Icon(Icons.message,
            color: Colors.black,
            size: 25.0,),
          title: Text('FAQ',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => faq()));
          },
        ),

        CustomDividerView(),


        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: new  Icon(Icons.account_balance,
            color: Colors.black,
            size: 25.0,),
          title: Text('My Profile',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => myaccount()));
          },
        ),
        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: new  Icon(Icons.line_style,
            color: Colors.black,
            size: 25.0,),
          title: Text('Order History',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => My_orders()));
          },
        ),
//        ListTile(
//          trailing: Icon(Icons.keyboard_arrow_right),
//          leading: new  Icon(Icons.directions_bus,
//            color: Colors.black,
//            size: 25.0,),
//          title: Text('Track Order',
//              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//          onTap: () {
//            Navigator.push(context,
//                MaterialPageRoute(builder: (context) => tracking()));
//          },
//        ),

        CustomDividerView(),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: Icon(
            Icons.library_books,
            color: Colors.black,
          ),
          title: Text('Blogs',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => All_branch()));
          },
        ),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: Icon(
            Icons.supervised_user_circle,
            color: Colors.black,
          ),
          title: Text('Clients',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => clientgallery()));
          },
        ),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: Icon(
            Icons.verified_user,
            color: Colors.black,
          ),
          title: Text('Testimonials',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => testimonials()));
          },
        ),

//        ListTile(
//          trailing: Icon(Icons.keyboard_arrow_right),
//          leading: Icon(
//            Icons.label_important,
//            color: Colors.black,
//          ),
//          title: Text('Notification',
//              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//          onTap: () {
//            Navigator.push(context,
//                MaterialPageRoute(builder: (context) => NotificationPage()));
//          },
//        ),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: Icon(
            Icons.photo,
            color: Colors.black,
          ),
          title: Text('Gallery',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => photogallery()));
          },
        ),


//        ListTile(
//          trailing: Icon(Icons.keyboard_arrow_right),
//          leading: Icon(
//            Icons.settings,
//            color: Colors.black,
//
//          ),
//          title: Text('Terms & Condition',
//              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//          onTap: () {
//    Navigator.push(
//    context, MaterialPageRoute(builder: (context) => TermsScreen()));},
//        ),

//        ListTile(
//          trailing: Icon(Icons.keyboard_arrow_right),
//          leading: Icon(
//            Icons.text_rotation_none,
//            color: Colors.black,
//          ),
//          title: Text('Privacy Policy',
//              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//          onTap: () {
//            Navigator.push(
//                context, MaterialPageRoute(builder: (context) => PolicyScreen()));},
//        ),

        CustomDividerView(),


        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: new  Icon(Icons.star,
              color: Colors.black,
              size: 25.0),
          title: Text('Rate App',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          onTap: () {
          },
        ),
        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: new Icon(Icons.share,
              color: Colors.black,
              size: 25.0),
          title: Text('Share App',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          onTap: () {
          },
        ),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: Icon(
            Icons.lock,
            color: Colors.black,

          ),
          title: Text('Log Out',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => logout()));
          },
        ),
      ],
    ));
  }
}
