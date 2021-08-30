import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myscrapcollector/screen/Customer/All_blogs_details.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:myscrapcollector/utils/app_colors.dart';
import 'package:myscrapcollector/utils/ui_helper.dart';

import 'package:myscrapcollector/widgets/AppDrawer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class All_branch extends StatefulWidget {
  @override
  _All_branchState createState() => _All_branchState();
}

class _All_branchState extends State<All_branch> {
  Future<List<allbranch>> _fetchallbranch() async {
    final url = 'http://myscrapcollector.com/beta/api/api.php?get_blogs';
    //var data = {'itemid': widget.itemnull};
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new allbranch.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget appBarTitle = new Text("Blogs");
  String pharmacyname = "";
  List<allbranch> data;

  @override
  void initState() {
    super.initState();
    _fetchdata();
  }

  void _fetchdata() async {
    data = await _fetchallbranch();
    setState(() {});
  }

  Future<void> _showSearch() async {
    await showSearch(
      context: context,
      delegate: TheSearch(data: data),
      query: pharmacyname,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              print(data.length);
              _showSearch();
              // setState(() {
              //   if ( this.actionIcon.icon == Icons.search){
              //     this.actionIcon = new Icon(Icons.close);
              //     this.appBarTitle = new TextField(
              //       style: new TextStyle(
              //         color: Colors.white,
              //
              //       ),
              //       decoration: new InputDecoration(
              //           prefixIcon: new Icon(Icons.search,color: Colors.white),
              //           hintText: "Search...",
              //           hintStyle: new TextStyle(color: Colors.black)
              //
              //       ),
              //       onChanged: (value){
              //         print(value);
              //         _showSearch();
              //
              //
              //       },
              //     );}
              //   else {
              //     this.actionIcon = new Icon(Icons.search);
              //     this.appBarTitle = new Text("Pharmacy");
              //   }
              //
              //
              // });
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: AllBranch(Key(data.toString()), data),
    );
  }
}

class TheSearch extends SearchDelegate<String> {
  TheSearch({this.contextPage, this.controller, @required this.data});

  List<allbranch> data;
  BuildContext contextPage;
  WebViewController controller;
  final suggestions1 = [];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: LightColor.red,
    );
  }

  @override
  String get searchFieldLabel => "Search";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Grid(
        context,
        data
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Grid(
        context,
        data
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList());
  }
}

class AllBranch extends StatefulWidget {
  AllBranch(this.key, this.data);
  final Key key;
  final List<allbranch> data;

  @override
  _AllBranchState createState() => _AllBranchState();
}

class allbranch {
  final String id;
  final String img;
  final String name;
  final String description;
  final String postedby;
  final String datee;
  allbranch({
    this.id,
    this.img,
    this.name,
    this.description,
    this.postedby,
    this.datee,
  });

  factory allbranch.fromJson(Map<String, dynamic> json) {
    return allbranch(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      postedby: json['postedby'],
      datee: json['datee'],
      img: json['img'],
    );
  }
}

class _AllBranchState extends State<AllBranch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
      body: widget.data == null
          ? CircularProgressIndicator()
          : Grid(context, widget.data),
    );
  }
}

Grid(context, data) {
  return GridView.builder(
    scrollDirection: Axis.vertical,
    itemCount: data.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 3.5),
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
                      return BranchDetails(todo: data[index]);
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
                    Container(
                      alignment: Alignment.topLeft,
                      height: 200.0,
                      width: 160.0,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5.0)
                          ],
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'http://myscrapcollector.com/beta/admin/images/blogss/' +
                                      data[index].img),
                              fit: BoxFit.fill)),
                    ),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                          Row(children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data[index].name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          ]),

                          Row(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data[index].postedby,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                    color: LightColor.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ]),

                          Html(
                              data: data[index].description.substring(0, 110) +
                                  '..'),

                              Row(
                                children: <Widget>[
                                  Text(
                                    '',
                                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  UIHelper.horizontalSpaceExtraSmall(),
                                  ClipOval(
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: swiggyOrange,
                                      height: 25.0,
                                      width: 25.0,
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              )

                        ])),
                  ]))));
    },
  );
}
