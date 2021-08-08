import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myscrapcollector/screen/Customer/precise.dart';
import 'package:myscrapcollector/screen/Customer/pickupresult.dart';
import 'package:myscrapcollector/screen/Customer/pickupsearchbox.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:myscrapcollector/widgets/AppDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class precise extends StatefulWidget {
  precise({Key key}) : super(key: key);
  @override
  _precise createState() => _precise();
}

class _precise extends State<precise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: LightColor.red,
        title: Text("Item Details"),
      ),

      body: AllBranchs(),
    );
  }
}

class AllBranchs extends StatefulWidget {
  @override
  _AllBranchsState createState() => _AllBranchsState();
}

class track {
  final String pickupid;
  final String itemname;
  final String qty;
  final String price;

  track({this.pickupid, this.itemname, this.qty, this.price});



  factory track.fromJson(Map<String, dynamic> json) {
    return track(
      pickupid: json['pickupid'],
      itemname: json['itemname'],
      qty: json['qty'],
      price: json['price'],


    );
  }
}

class _AllBranchsState extends State<AllBranchs> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<track>>(
        future: _fetchallbranch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<track> data = snapshot.data;
            return Grid(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Future<List<track>> _fetchallbranch() async {
    SharedPreferences pf = await SharedPreferences.getInstance();
    String f = pf.getString("pickupid");
    final url =
        'http://myscrapcollector.com/beta/api/tracking.php?pickupid=' + f;

    var response = await http.get(url);
    print(url);
    print(response.body.toString());

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new track.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

Grid(context, data) {
  return GridView.builder(
    scrollDirection: Axis.vertical,
    itemCount: data.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 5),
        crossAxisCount: 1),
    itemBuilder: (context, index) {
      return Card(
          child: Container(
              child: Row(children: <Widget>[
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(top: 10.0, left: 15.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[
                  Text(
                    'Item Name - ' + data[index].itemname,
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
                    overflow: TextOverflow.ellipsis,
                  ),
                ]),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    'Qty - ' + data[index].qty,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        color: Colors.green),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  child: Text(
                    'Price - ' + data[index].price,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        color: Colors.green),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

              ]),
        )),
      ])));
    },
  );
}
