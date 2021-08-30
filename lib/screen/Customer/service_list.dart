import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:myscrapcollector/utils/ui_helper.dart';
import 'package:myscrapcollector/widgets/AppDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceList extends StatefulWidget {
  @override
  _ServiceListState createState() => _ServiceListState();
}

class ServiceData {
  final String userId;
  final String name;
  final String description;
  final String img;

  ServiceData({this.userId, this.name, this.description, this.img});

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
      userId: json['userId'],
      name: json['name'],
      description: json['description'],
      img: json['img'],
    );
  }
}

class _ServiceListState extends State<ServiceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Services"),
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
    var data = {'email': token};
    final url = 'http://myscrapcollector.com/beta/api/api.php?get_services';

    var response = await http.post(url, body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new ServiceData.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Grid(context, data) {
    return GridView.builder(
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.6),
          crossAxisCount: 2),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
//              setState(() {
//                cust_id = data[index].userId;
//              });
//              addtofav();
//              Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                      builder: (context) => Cust_Details(todo: data[index])));
            },
            // var finalprice = data[index].price;
            child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        border: Border(
                          bottom:
                              BorderSide(color: Colors.grey[300], width: 1.5),
                          top: BorderSide(color: Colors.grey[300], width: 1.5),
                        )),
                    height: 50.0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          height: 100.0,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12, blurRadius: 5.0)
                              ],
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    'http://myscrapcollector.com/beta/admin/images/services/' +
                                        data[index].img,
                                  ),
                                  fit: BoxFit.fitWidth)),
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data[index].name,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "\ ${data[index].description}",
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.grey),
                              ),
                            ),
                            // SizedBox(height: 20),
                          ],
                        ))
                      ],
                    ),
                  ),
                )));
      },
    );
  }
}
