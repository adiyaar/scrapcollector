import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Account {
  final String user_id;
  final String userName;

  final String userEmail;
  final String address;
  final String area;
  final String pincode;
  final String city;
  final String state;
  final String entityvalue;
  final String entityname;

  final String mobile;

  Account(
      {this.user_id,
      this.userName,
      this.mobile,
      this.userEmail,
      this.address,
      this.area,
      this.pincode,
      this.city,
      this.state,
      this.entityname,
      this.entityvalue});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      user_id: json['user_id'],
      userName: json['userName'],
      mobile: json['mobile'],
      userEmail: json['userEmail'],
      address: json['address'],
      area: json['area'],
      pincode: json['pincode'],
      city: json['city'],
      state: json['state'],
      entityvalue: json['entityvalue'],
      entityname: json['entityname'],
    );
  }
}

class myaccount extends StatefulWidget {
  @override
  _myaccountState createState() => _myaccountState();
}

class _myaccountState extends State<myaccount> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String userName,
      lastname,
      email,
      mobile,
      userEmail,
      address,
      area,
      pincode,
      city,
      state,
      entityvalue,
      entityname;
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user_id = prefs.getString('id');
    return user_id;
  }

  Future update_acc() async {
    dynamic token = await getStringValues();

    // SERVER API URL
    var url = 'http://myscrapcollector.com/beta/api/updateprofile.php';
    print(userName);
    print(mobile);
    // Store all data with Param Name.
    var data = {
      'userid': token,
      'userName': userName,
      'mobile': mobile,
      'mobile': mobile,
      'userEmail': userEmail,
      'address': address,
      'area': area,
      'pincode': pincode,
      'city': city,
      'state': state,
      'entityvalue': entityvalue,
      'entityname': entityname
    };

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);
    showInSnackBar(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text("My Profile")),
        body: FutureBuilder<List<Account>>(
          future: _fetchaccount(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Account> data = snapshot.data;
              if (snapshot.data.length == 0) {
                return Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 80));
                //child: Image.asset("assets/cart.png"));
              }

              return imageSlider(context, data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(
                child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
            ));
          },
        ),
        floatingActionButton: Container(
            height: 50.0,
            width: 150.0,
            //child: FittedBox(
            child: FloatingActionButton.extended(
              //  icon: Icon(Icons.add_shopping_cart),
              //  label: Text("Add to Cart"),
              backgroundColor: LightColor.red,
              onPressed: () {
                update_acc();
              },
              // icon: Icon(Icons.save),
              label: Center(
                  child: Text(
                "Update",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
            )));
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: LightColor.midnightBlue,
    ));
  }

  Future<List<Account>> _fetchaccount() async {
    dynamic token = await getStringValues();
    print(token);
    var data = {'userid': token};
    var url = 'http://myscrapcollector.com/beta/api/accountdetails.php';
    var response = await http.post(url, body: json.encode(data));
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => new Account.fromJson(item)).toList();
  }

  imageSlider(context, data) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, index) {
          userName = data[index].userName;
          mobile = data[index].mobile;
          userEmail = data[index].userEmail;
          address = data[index].address;
          area = data[index].area;
          pincode = data[index].pincode;
          city = data[index].city;
          state = data[index].state;
          entityname = data[index].entityname;
          entityvalue = data[index].entityvalue;

          print(mobile);
          return InkWell(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "\  Full Name ",
                          style: TextStyle(color: Colors.grey,
                              fontWeight: FontWeight.w600, fontSize: 15.0),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          child: Container(
                            height: 35,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: TextFormField(
                                autofocus: false,
                                initialValue: data[index].userName,
                                // controller: userNameController,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                onChanged: (text) {
                                  userName = text;
                                },
                              ),
                            ),
                          ),
                          //color: Colors.white38,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "\  Mobile No ",
                          style: TextStyle(color: Colors.grey,
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Card(
                          child: Container(
                            height: 35,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: TextFormField(
                                autofocus: false,
                                initialValue: data[index].mobile,
                                //controller: emailController,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                onChanged: (text) {
                                  mobile = text;
                                },
                              ),
                            ),
                          ),
                          //color: Colors.white38,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),


                        Text(
                          "\  Email Id ",
                          style: TextStyle(color: Colors.grey,
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Card(
                          child: Container(
                            height: 35,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: TextFormField(
                                autofocus: false,
                                initialValue: data[index].userEmail,
                                //controller: emailController,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                onChanged: (text) {
                                  userEmail = text;
                                },
                              ),
                            ),
                          ),
                          //color: Colors.white38,
                        ),






                        SizedBox(
                          height: 15.0,
                        ),


                        Text(
                          "\  Address ",
                          style: TextStyle(color: Colors.grey,
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Card(
                          child: Container(
                            height: 35,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: TextFormField(
                                autofocus: false,
                                initialValue: data[index].address,
                                //controller: emailController,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                onChanged: (text) {
                                  address = text;
                                },
                              ),
                            ),
                          ),
                          //color: Colors.white38,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),


                        Text(
                          "\  Area",
                          style: TextStyle(color: Colors.grey,
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Card(
                          child: Container(
                            height: 35,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: TextFormField(
                                autofocus: false,
                                initialValue: data[index].area,
                                //controller: emailController,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                onChanged: (text) {
                                  area = text;
                                },
                              ),
                            ),
                          ),
                          //color: Colors.white38,
                        ),



                        Text(
                          "\  City",
                          style: TextStyle(color: Colors.grey,
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Card(
                          child: Container(
                            height: 35,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: TextFormField(
                                autofocus: false,
                                initialValue: data[index].city,
                                //controller: emailController,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                onChanged: (text) {
                                  city = text;
                                },
                              ),
                            ),
                          ),
                          //color: Colors.white38,
                        ),

                        Text(
                          "\  Pincode",
                          style: TextStyle(color: Colors.grey,
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Card(
                          child: Container(
                            height: 35,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: TextFormField(
                                autofocus: false,
                                initialValue: data[index].pincode,
                                //controller: emailController,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                onChanged: (text) {
                                  pincode = text;
                                },
                              ),
                            ),
                          ),
                          //color: Colors.white38,
                        ),

                        Text(
                          "\  State",
                          style: TextStyle(color: Colors.grey,
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Card(
                          child: Container(
                            height: 35,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: TextFormField(
                                autofocus: false,
                                initialValue: data[index].state,
                                //controller: emailController,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                onChanged: (text) {
                                  state = text;
                                },
                              ),
                            ),
                          ),
                          //color: Colors.white38,
                        ),

                        Text(
                          "\  Entity Name",
                          style: TextStyle(color: Colors.grey,
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Card(
                          child: Container(
                            height: 35,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: TextFormField(
                                autofocus: false,
                                initialValue: data[index].entityname,
                                //controller: emailController,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                onChanged: (text) {
                                  entityname = text;
                                },
                              ),
                            ),
                          ),
                          //color: Colors.white38,
                        ),

                        Text(
                          "\  Entity Value",
                          style: TextStyle(color: Colors.grey,
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Card(
                          child: Container(
                            height: 35,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: TextFormField(
                                autofocus: false,
                                initialValue: data[index].entityvalue,
                                //controller: emailController,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                onChanged: (text) {
                                  entityvalue = text;
                                },
                              ),
                            ),
                          ),
                          //color: Colors.white38,
                        ),



                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
