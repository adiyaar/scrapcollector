import 'package:flutter/material.dart';
import 'package:myscrapcollector/screen/Customer/pickupresult.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class tracking extends StatefulWidget {
  @override
  _All_branchState createState() => _All_branchState();
}

class _All_branchState extends State<tracking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: LightColor.red,
        title: Text("Tracking"),
      ),

      body: AllBranch(),
    );
  }
}

class AllBranch extends StatefulWidget {
  @override
  _AllBranchState createState() => _AllBranchState();
}

class allbranch {
  final String id;
  final String pickupdate;
  final String pickuptime;
  final String userid;
  final String employeeid;
  final String status;

  allbranch(
      {this.id,
      this.pickupdate,
      this.pickuptime,
      this.userid,
      this.employeeid,
      this.status});

  factory allbranch.fromJson(Map<String, dynamic> json) {
    return allbranch(
      id: json['id'],
      pickupdate: json['pickupdate'],
      pickuptime: json['pickuptime'],
      userid: json['userid'],
      employeeid: json['employeeid'],
      status: json['status'],
    );
  }
}

class _AllBranchState extends State<AllBranch> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 88.0),
                child: Text(
                  "Search With Your Pickup Id",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: controller,
                decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(24.0)),
                  hintText: 'Enter Your Pickup Id ',
                  labelText: 'Pickup Id ',
                  prefixIcon: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: LightColor.red,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Search",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  onPressed: () async {
                    SharedPreferences pf =
                        await SharedPreferences.getInstance();
                    pf.setString("docket", controller.text);
                    print(controller.text);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => trackingresult()));
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
