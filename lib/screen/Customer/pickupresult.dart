import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myscrapcollector/screen/Customer/pickupsearchdetails.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:myscrapcollector/widgets/AppDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class trackingresult extends StatefulWidget {
  @override
  _tstate createState() => _tstate();
}

class _tstate extends State<trackingresult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: LightColor.red,
        title: Text("Tracking Results"),
      ),
      drawer: AppDrawer(),
      body: AllBranchs(),
    );
  }
}

class AllBranchs extends StatefulWidget {
  @override
  _AllBranchsState createState() => _AllBranchsState();
}

class allbranchs {
  final String id;
  final String pickupdate;
  final String pickuptime;
  final String userid;
  final String employeeid;
  final String address;
  final String firstname;
  final String username;
  final String city;
  final String pincode;
  final String state;
  final String country;
  final String status;

  allbranchs(
      {this.id,
      this.pickupdate,
      this.pickuptime,
      this.userid,
      this.employeeid,
      this.address,
      this.firstname,
      this.username,
      this.city,
      this.pincode,
      this.state,
      this.country,
      this.status});

  factory allbranchs.fromJson(Map<String, dynamic> json) {
    return allbranchs(
      id: json['id'],
      pickupdate: json['pickupdate'],
      pickuptime: json['pickuptime'],
      userid: json['userid'],
      employeeid: json['employeeid'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      pincode: json['pincode'],
      country: json['country'],
      firstname: json['firstname'],
      username: json['username'],
      status: json['status'],
    );
  }
}

class _AllBranchsState extends State<AllBranchs> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<allbranchs>>(
        future: _fetchallbranch(dock),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<allbranchs> data = snapshot.data;
            return Grid(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  String dock;

  SharedPreferences pf;
  Future<List<allbranchs>> _fetchallbranch(dock) async {
    pf = await SharedPreferences.getInstance();
    dock = pf.getString("docket");

    final url =
        'http://myscrapcollector.com//beta/api/track.php?docketno=' + dock;

    var response = await http.get(url);

    print(response.body.toString());

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse.map((job) => new allbranchs.fromJson(job)).toList();
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
            (MediaQuery.of(context).size.height / 7),
        crossAxisCount: 1),
    itemBuilder: (context, index) {
      return InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    transitionsBuilder:
                        (context, animation, animationTime, child) {
                      return SlideTransition(
                        position: Tween(
                                begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                            .animate(animation),
                        child: child,
                      );
                    },
                    pageBuilder: (context, animation, animationTime) {
                      return trackingdetails(todo: data[index]);
                    })
                //
                );
            /*Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BranchDetails(todo: data[index])));
             */
          },
          // var finalprice = data[index].price;
          child: Card(
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
                        'PickUp Id - ' + data[index].id,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        'Status - ' + data[index].status,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                            color: Colors.green),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
            )),
          ]))));
    },
  );
}
