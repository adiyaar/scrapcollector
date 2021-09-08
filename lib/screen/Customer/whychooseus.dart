import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:myscrapcollector/utils/ui_helper.dart';
import 'package:myscrapcollector/widgets/AppDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Whychooseus extends StatefulWidget {
  @override
  _WhychooseusState createState() => _WhychooseusState();
}

class ServiceData {
  final String userId;
  final String title;
  final String description;
  final String img;

  ServiceData({this.userId, this.title, this.description, this.img});

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
      userId: json['id'],
      title: json['title'],
      description: json['description'],
      img: json['img'],
    );
  }
}

class _WhychooseusState extends State<Whychooseus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Why Choose Us"),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder<List<ServiceData>>(
        future: _fetchItemGrpData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ServiceData> data = snapshot.data;
            return Grid(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(LightColor.red),
              ));
        },
      ),
    );
  }

  var cust_id;

  bool visible = false;
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String user_id = prefs.getString('id');
    return user_id;
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String emailValue = prefs.getString('email');
    return emailValue;
  }

  Future<List<ServiceData>> _fetchItemGrpData() async {
    dynamic token = await getStringValuesSF();

    final url = 'http://myscrapcollector.com/beta/api/api.php?get_whychooseus';

    var response = await http.post(url, );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new ServiceData.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Grid(context, data) {
    return ListView.builder(
      itemCount: data.length,
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     childAspectRatio: MediaQuery.of(context).size.width /
      //         (MediaQuery.of(context).size.height / 3.6),
      //     crossAxisCount: 1),
      // scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Container(
          child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 100.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                'http://myscrapcollector.com/beta/admin/images/whychooseus/' +
                                    data[index].img,
                              ),
                              fit: BoxFit.contain)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 20.0,top: 15),
                          child: Text(
                            data[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16.0,color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),



                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 20.0,top: 15),
                          child: Text(

                            "In publishing and graphic ",
                            softWrap: true,
                            style: TextStyle(

                                fontWeight: FontWeight.w600, fontSize: 16.0,color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        // Text(
                        //   "\ ${data[index].description}",
                        //   maxLines: 1,
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodyText1
                        //       .copyWith(color: Colors.grey),
                        // ),
                      ],
                    ),


                  ],
                ),
              )),
        );
      },
    );
  }
}
