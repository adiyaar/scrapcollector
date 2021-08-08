import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:myscrapcollector/utils/ui_helper.dart';
import 'package:myscrapcollector/widgets/AppDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PriceList extends StatefulWidget {
  @override
  _PriceListState createState() => _PriceListState();
}

class PriceData {
  final String userId;
  final String title;
  final String description;
  final String units;
  final String qty;
  final String img;

  PriceData({this.userId, this.title, this.description, this.img, this.units,this.qty});

  factory PriceData.fromJson(Map<String, dynamic> json) {
    return PriceData(
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      img: json['img'],
      units: json['units'],
      qty: json['qty'],
    );
  }
}

class _PriceListState extends State<PriceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Price List"),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder<List<PriceData>>(
        future: _fetchItemGrpData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<PriceData> data = snapshot.data;
            return Grid(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
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

  Future<List<PriceData>> _fetchItemGrpData() async {
    dynamic token = await getStringValuesSF();
    var data = {'email': token};
    final url = 'http://myscrapcollector.com/beta/api/api.php?get_products';

    var response = await http.post(url, body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new PriceData.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Grid(context, data) {
    return GridView.builder(
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.0),
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
                    height: 150.0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          height: 200.0,
                          width: 150.0,
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
                                    'http://myscrapcollector.com/beta/admin/images/products/' +
                                        data[index].img,
                                  ),
                                  fit: BoxFit.fitWidth)),
                        ),
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.0, left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[


                                  Text(
                                    data[index].title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 10),


                                  UIHelper.verticalSpaceSmall(),
                                  Text(
                                    "\ ${data[index].description}",
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 13.0) ,
                                  ),


                                  SizedBox(height: 10),

                                  Text(
                                    'Rs '+data[index].qty+'/- '+data[index].units,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0),
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                )));
      },
    );
  }
}

