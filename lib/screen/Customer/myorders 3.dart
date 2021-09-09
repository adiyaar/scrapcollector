import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myscrapcollector/screen/Customer/myorders_detail.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:myscrapcollector/widgets/AppDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class My_orders extends StatefulWidget {
  @override
  _My_ordersState createState() => _My_ordersState();
}

class _My_ordersState extends State<My_orders> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: LightColor.red,
            title: Text("My Orders"),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text("Pending Orders"),
                ),
                Tab(
                  child: Text("Completed Orders"),
                ),
              ],
            ),
          ),
          drawer: AppDrawer(),
          body: TabBarView(
            children: [AllBranch(), test()],
          ),
        ),
      ),
    );
  }
}

// test is completed orders
// all branch is pending orders
class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

class complete {
  final String id;
  final String userid;
  final String pickupdate;
  final String pickuptime;
  final String status;
  final String employeeid;
  final String area;
  final String address;
  final String city;
  final String state;
  final String pincode;
  final String wedeliveryin;
  final String firstname;
  final String username;
  final String useremail;
  final String mobile;
  final String contactno;
  complete({
    this.id,
    this.userid,
    this.pickupdate,
    this.pickuptime,
    this.status,
    this.employeeid,
    this.area,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.wedeliveryin,
    this.firstname,
    this.username,
    this.useremail,
    this.mobile,
    this.contactno,
  });

  factory complete.fromJson(Map<String, dynamic> json) {
    return complete(
      id: json['id'],
      userid: json['userid'],
      pickupdate: json['pickupdate'],
      pickuptime: json['pickuptime'],
      status: json['status'],
      employeeid: json['employeeid'],
      area: json['area'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      pincode: json['pincode'],
      wedeliveryin: json['wedeliveryin'],
      firstname: json['firstname'],
      username: json['username'],
      useremail: json['useremail'],
      mobile: json['mobile'],
      contactno: json['contactno'],
    );
  }
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<complete>>(
        future: _fetchallbranch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<complete> data = snapshot.data;
            return Grid(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData == null) {
            return Container(
              child: Text("No Orders Pending"),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List<complete>> _fetchallbranch() async {
    SharedPreferences pf = await SharedPreferences.getInstance();
    String id = pf.getString("id");
    print(id);
    final url = 'http://myscrapcollector.com//beta/api/myorders2.php';
    var data = ({'userid': id});
    var response = await http.post(Uri.parse(url), body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new complete.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

class AllBranch extends StatefulWidget {
  @override
  _AllBranchState createState() => _AllBranchState();
}

class myorders {
  final String id;
  final String userid;
  final String pickupdate;
  final String pickuptime;
  final String status;
  final String employeeid;
  final String area;
  final String address;
  final String city;
  final String state;
  final String pincode;
  final String wedeliveryin;
  final String firstname;
  final String username;
  final String useremail;
  final String mobile;
  final String contactno;
  myorders({
    this.id,
    this.userid,
    this.pickupdate,
    this.pickuptime,
    this.status,
    this.employeeid,
    this.area,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.wedeliveryin,
    this.firstname,
    this.username,
    this.useremail,
    this.mobile,
    this.contactno,
  });

  factory myorders.fromJson(Map<String, dynamic> json) {
    return myorders(
      id: json['id'],
      userid: json['userid'],
      pickupdate: json['pickupdate'],
      pickuptime: json['pickuptime'],
      status: json['status'],
      employeeid: json['employeeid'],
      area: json['area'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      pincode: json['pincode'],
      wedeliveryin: json['wedeliveryin'],
      firstname: json['firstname'],
      username: json['username'],
      useremail: json['useremail'],
      mobile: json['mobile'],
      contactno: json['contactno'],
    );
  }
}

class _AllBranchState extends State<AllBranch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<myorders>>(
        future: _fetchallbranch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<myorders> data = snapshot.data;
            return Grid(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData == null) {
            return Container(
              child: Text("No Orders Pending"),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List<myorders>> _fetchallbranch() async {
    SharedPreferences pf = await SharedPreferences.getInstance();
    String id = pf.getString("id");
    print(id);
    final url = 'http://myscrapcollector.com//beta/api/myorders.php';
    var data = ({'userid': id});
    var response = await http.post(Uri.parse(url), body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new myorders.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

// ignore: non_constant_identifier_names
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
                      return MyOrderDetails(todo: data[index]);
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
                  decoration: BoxDecoration(
                      color: Colors.white12,
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
                                'Pickup Date - ' + data[index].pickupdate,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.0),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Pickup Time - ' + data[index].pickuptime,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13.0),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              data[index].status,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15.0),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ]),
                    )),
                  ]))));
    },
  );
}
