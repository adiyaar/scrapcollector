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
            // return moredetail(context, data);
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(
                      label: Text(
                    'Itemname',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  DataColumn(
                      label: Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  DataColumn(
                      label: Text(
                    'Price',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  DataColumn(
                      label: Text(
                    'Quantity',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  DataColumn(
                      label: Text(
                    'Units',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  // DataColumn(label: Text('Amount')),
                ],
                rows: data
                    .map((data) => DataRow(cells: [
                          DataCell(Container(
                              width: 40,
                              child: Text(
                                data.itemname,
                                style: TextStyle(fontSize: 11),
                              ))),
                          DataCell(Container(
                              width: 20,
                              child: Text(
                                data.description,
                                style: TextStyle(fontSize: 11),
                              ))),
                          DataCell(Container(
                              width: 20,
                              child: Text(
                                data.price,
                                style: TextStyle(fontSize: 11),
                              ))),
                          DataCell(Container(
                              width: 20,
                              child: Text(
                                data.qty,
                                style: TextStyle(fontSize: 11),
                              ))),
                          DataCell(Container(
                              width: 20,
                              child: Text(
                                data.units,
                                style: TextStyle(fontSize: 11),
                              ))),
                          // DataCell(Container(width:60,child:Text((data.units)*int.parse(data.price),style: TextStyle(fontSize: 11),))),
                        ]))
                    .toList(),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text("No Data Found For Your Current Selection"));
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
        onPressed: () {},
        label: Text("Total Amount = $subtotal"),
        backgroundColor: Colors.red,
      ),
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
                            'ItemName - ' +
                                data[index].itemname +
                                ' - ' +
                                data[index].description,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14.0),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Qty - ' + data[index].qty + ' ' + data[index].units,
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
  final String description;
  final String units;

  itemdetail({
    this.itemname,
    this.qty,
    this.price,
    this.description,
    this.units,
  });

  factory itemdetail.fromJson(Map<String, dynamic> json) {
    return itemdetail(
      itemname: json['itemname'],
      qty: json['qty'],
      price: json['price'],
      description: json['description'],
      units: json['units'],
    );
  }
}
