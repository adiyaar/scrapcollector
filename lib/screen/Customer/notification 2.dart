import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:expansion_card/expansion_card.dart';
import 'dart:convert';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class faqItem  {
  final String title;
  final String description;
  final String id;

  faqItem({this.title, this.description, this.id, });

  factory faqItem.fromJson(Map<String, dynamic> json) {
    return faqItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],

    );
  }
}


class notification extends StatefulWidget {
  @override
  _notificationState createState() => _notificationState();

}

class _notificationState extends State<notification> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Notification")),
      body:
      FutureBuilder<List<faqItem>>(
        future: _fetchCartItem(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<faqItem> data = snapshot.data;
            if (snapshot.data.length == 0) {
              return Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 80));
              //child: Image.asset("assets/cart.png"));
            }

            return imageSlider(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
              child: CircularProgressIndicator(
                valueColor:
                AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
              ));
        },
      ),


    );
  }


  Future<List<faqItem>> _fetchCartItem() async {

    var url = 'http://myscrapcollector.com/beta/api/api.php?get_notification';
    var response = await http.post(url);

    List jsonResponse = json.decode(response.body);

    return jsonResponse.map((item) => new faqItem.fromJson(item)).toList();
  }

  imageSlider(context, data) {

    return
      ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, index) {

          return   Card(
            child: ExpansionTile(
              // leading: Icon(FontAwesomeIcons.sign),
              title: Text(data[index].title),
              // subtitle: Text("  Sub Title's"),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Html(
                    data: data[index].description,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

              ],

            ),
          );
        },




      );
  }


}
