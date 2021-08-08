import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:myscrapcollector/screen/Customer/myorders_detail.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:myscrapcollector/widgets/AppDrawer.dart';

class My_orders extends StatefulWidget {
  @override
  _My_ordersState createState() => _My_ordersState();
}

class _My_ordersState extends State<My_orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: LightColor.red,
        title: Text("My Orders"),
      ),
      drawer: AppDrawer(),
      body: AllBranch(),
    );
  }
}

class AllBranch extends StatefulWidget {
  @override
  _AllBranchState createState() => _AllBranchState();
}

class myorders {
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



  myorders(
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

  factory myorders.fromJson(Map<String, dynamic> json) {
    return myorders(
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
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Future<List<myorders>> _fetchallbranch() async {
    final url = 'http://myscrapcollector.com//beta/api/myorders.php';
    //var data = {'itemid': widget.itemnull};
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new myorders.fromJson(job)).toList();
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
                  height: 100.0,
                  child: Row(children: <Widget>[

                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 15.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  Text(
                                    data[index].firstname,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.0),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ]),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    child: Html(
                                      data: data[index].address,
                                    )),
                              ]),
                        )),
                  ]))));
    },
  );
}

/*
 return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: data.length,
    itemBuilder: (context, index) {
      return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BranchDetails(todo: data[index])));
          },
          // var finalprice = data[index].price;
          child: Card( //
            //                         <-- Card widget
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 50,
                    child: Image.network(

                      data[index].img,
                      fit: BoxFit.fitWidth,
                      // height:500 , width: 500,

                    ),
                  ),
                  ListTile(
                    // leading: Icon(icons[index]),

                    title: Text(
                      data[index].branchecommercename, style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16.0),),
                  ),
                ]),
          )
      );
    },
  );
}

*/
