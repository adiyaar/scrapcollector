import 'dart:convert';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myscrapcollector/screen/home_screen.dart';
import 'package:myscrapcollector/screen/homepage/home_pricelist.dart';
import 'package:myscrapcollector/screen/pickup.dart';
import 'package:myscrapcollector/static/About_Us.dart';
import 'package:myscrapcollector/static/Contact_Us.dart';
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

  PriceData(
      {this.userId,
        this.title,
        this.description,
        this.img,
        this.units,
        this.qty});

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
  Future<List<Job1>> fetchJobs() async {
    final jobsListAPIUrl =
        'http://myscrapcollector.com/beta/api/api.php?get_products';
    final response = await http.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Job1.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Future<List<StaticPage>> _fetchStaticPage() async {
    final jobsListAPIUrl =
        'http://myscrapcollector.com/beta/api/api.php?get_pricelist';
    final response = await http.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new StaticPage.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Price List"),
        ),
        drawer: AppDrawer(),
        body: ListView(
          children: [
            Column(
              children: [
                FutureBuilder<List<Job1>>(
                  future: fetchJobs(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Job1> data = snapshot.data;

                      return imageSlider2(context, data);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              LightColor.red),
                        ));
                  },
                ),
                Container(
                  height: 100,
                  child: FutureBuilder<List<StaticPage>>(
                    future: _fetchStaticPage(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<StaticPage> data = snapshot.data;
                        return imageSlider(context, data);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                LightColor.red),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: LightColor.red,
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.done_all, title: 'Price List'),
            TabItem(icon: Icons.directions_bus, title: 'Pick Up'),
            TabItem(
                icon: InkWell(
                  onTap: () async {
                    await callNumber();
                  },
                  child: Icon(Icons.call,color: Colors.red[200],),
                ),
                title: 'Call Us'),
            TabItem(icon: Icons.contact_phone, title: 'Contact Us'),
          ],
          initialActiveIndex: 1, //optional, default as 0

          onTap: (index) {
            if (index == 0) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            } else if (index == 1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PriceList()));
            } else if (index == 2) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => pickupForm()));
            } else if (index == 3) {
            } else if (index == 4) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Contact_Us()));
            }
          },
        ));
  }

  // Grid(context, data) {
  //   return Container(
  //     height: (data.length / 2) * 200,
  //     child: GridView.builder(
  //       physics: NeverScrollableScrollPhysics(),
  //       itemCount: data.length,
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //           childAspectRatio: MediaQuery.of(context).size.width /
  //               (MediaQuery.of(context).size.height / 1.3),
  //           crossAxisCount: 2),
  //       scrollDirection: Axis.vertical,
  //       itemBuilder: (context, index) {
  //         return Card(
  //           child: Container(
  //
  //             decoration: BoxDecoration(
  //                 color: Colors.white12,
  //                 border: Border(
  //                   bottom: BorderSide(color: Colors.grey[300], width: 1.5),
  //                   top: BorderSide(color: Colors.grey[300], width: 1.5),
  //                 )),
  //             height: 100.0,
  //             child: Column(
  //               children: <Widget>[
  //                 Container(
  //                   alignment: Alignment.topLeft,
  //                   height: 120.0,
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.only(
  //                           topRight: Radius.circular(10.0),
  //                           bottomRight: Radius.circular(10.0)),
  //                       image: DecorationImage(
  //                           image: NetworkImage(
  //                             'http://myscrapcollector.com/beta/admin/images/products/' +
  //                                 data[index].img,
  //                           ),
  //                           fit: BoxFit.fitWidth)),
  //                 ),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     Padding(
  //                       padding: const EdgeInsets.only(left: 8.0, top: 8.0),
  //                       child: Text(
  //                         data[index].title,
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.w600, fontSize: 16.0),
  //                         overflow: TextOverflow.ellipsis,
  //                       ),
  //                     ),
  //                     Html(data: data[index].description + '..'),
  //                     Padding(
  //                       padding: const EdgeInsets.only(left: 8.0, top: 8.0),
  //                       child: Text(
  //                         'Rs ' + data[index].qty + '/- ' + data[index].units,
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.w600, fontSize: 16.0),
  //                         overflow: TextOverflow.ellipsis,
  //                       ),
  //                     ),
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}
// html data
imageSlider(context, data) {
  return Container(

    child: ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          // child: Html(
          //   data: data[index].content,
          // ),
          child: Html(data : data[index].content),
        );
      },
    ),
  );
}



// price list 3 ke grid mei
imageSlider2(context, data) {
  print(data.length / 3 * 200);
  return Container(
    height: (data.length / 3) * 110,
    // height: 260,
    child: GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2.1),
          crossAxisCount: 3),
      itemCount: data.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            decoration: BoxDecoration(
            border: Border(
                              bottom: BorderSide(color: Colors.black, ),
                              top: BorderSide(color: Colors.black, ),
              right: BorderSide(color: Colors.black, ),
              left: BorderSide(color: Colors.black, ),
                            ),
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Text(
                  data[index].title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 40.0,
                  child: Image.network(
                    'http://myscrapcollector.com/beta/admin/images/products/' +
                        data[index].img,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '₹ ' + data[index].qty + ' ' + data[index].units,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,),
                  overflow: TextOverflow.ellipsis,
                ),

              ]),
          ),
        );
      },
    ),
  );
}
