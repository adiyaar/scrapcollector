import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'myorders.dart';
import 'package:http/http.dart' as http;
import 'myorders_detail.dart';

class moredetails extends StatefulWidget {
  myorders todo;
  moredetails({Key key, @required this.todo}) : super(key: key);

  @override
  _moredetailsState createState() => _moredetailsState();
}

class _moredetailsState extends State<moredetails> {
  double subtotal = 0.0;

  Future<List<itemdetail>> fetchmore() async {
    final url = 'http://myscrapcollector.com/beta/api/myorderitems.php';
    var data = ({'pickupid': widget.todo.id});
    print(widget.todo.id);
    var response = await http.post(Uri.parse(url), body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      List<itemdetail> temp =
          jsonResponse.map((item) => new itemdetail.fromJson(item)).toList();
      subtotal = temp.map((e) {
        return double.parse(e.price);
      }).reduce(
        (value, element) => value + element,
      );
      print(subtotal);
      print("2");
      setState(() {});
      return jsonResponse.map((job) => new itemdetail.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchmore(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<itemdetail> data = snapshot.data;
            return moredetail(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData == null) {
            return Container(
              child: Text("No Orders Pending"),
            );
          }
          return Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(LightColor.red),
          ));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {}, label: Text("Subtotal = $subtotal")),
    );
  }
}

moredetail(context, data) {
  return GridView.builder(
    scrollDirection: Axis.vertical,
    itemCount: data.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 8),
        crossAxisCount: 1),
    itemBuilder: (context, index) {
      return Card(
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.red[50],
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.5),
                    top: BorderSide(color: Colors.grey[300], width: 1.5),
                  )),
              child: Row(children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Text(
                            'ItemName - ' + data[index].itemname,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14.0),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Qty - ' + data[index].qty,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14.0),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Amount - ' + data[index].price,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14.0),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ]),
                )),
              ])));
    },
  );
}

class itemdetail {
  final String itemname;
  final String qty;
  final String price;

  itemdetail({
    this.itemname,
    this.qty,
    this.price,
  });

  factory itemdetail.fromJson(Map<String, dynamic> json) {
    return itemdetail(
      itemname: json['itemname'],
      qty: json['qty'],
      price: json['price'],
    );
  }
}
