// import 'dart:convert';
// import 'package:custom_full_image_screen/custom_full_image_screen.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:myscrapcollector/theme/light_color.dart';
// import 'package:myscrapcollector/widgets/AppDrawer.dart';
//
// class photogallery extends StatefulWidget {
//   @override
//   _photogalleryState createState() => _photogalleryState();
// }
//
// class _photogalleryState extends State<photogallery> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // resizeToAvoidBottomPadding: false,
//       appBar: AppBar(
//         backgroundColor: LightColor.red,
//         title: Text("Photo Gallery"),
//       ),
//       drawer: AppDrawer(),
//       body: AllBranch(),
//     );
//   }
// }
//
// class AllBranch extends StatefulWidget {
//   @override
//   _AllBranchState createState() => _AllBranchState();
// }
//
// class allbranch {
//   final String id;
//   final String img;
//
//   allbranch({this.id, this.img});
//
//   factory allbranch.fromJson(Map<String, dynamic> json) {
//     return allbranch(
//       id: json['id'],
//       img: json['img'],
//     );
//   }
// }
//
// class _AllBranchState extends State<AllBranch> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<allbranch>>(
//         future: _fetchallbranch(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<allbranch> data = snapshot.data;
//             return Grid(context, data);
//           } else if (snapshot.hasError) {
//             return Text("${snapshot.error}");
//           }
//           return CircularProgressIndicator();
//         },
//       ),
//     );
//   }
//
//   Future<List<allbranch>> _fetchallbranch() async {
//     final url = 'http://myscrapcollector.com/beta/api/api.php?get_gallery';
//     //var data = {'itemid': widget.itemnull};
//     var response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse.map((job) => new allbranch.fromJson(job)).toList();
//     } else {
//       throw Exception('Failed to load jobs from API');
//     }
//   }
// }
//

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:myscrapcollector/widgets/AppDrawer.dart';

import 'All_blogs.dart';

class photogallery extends StatelessWidget {
  Future<List<allbranch>> _fetchallbranch() async {
    final url = 'http://myscrapcollector.com/beta/api/api.php?get_gallery';

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new allbranch.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Grid(context, data) {
    return Container(
      height: (data.length/2)*200,
      child: GridView.builder(

        scrollDirection: Axis.vertical,
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 3),
            crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'http://myscrapcollector.com/beta/admin/images/gallery/' +
                              data[index].img),
                      fit: BoxFit.fill)),
            ),
          );
        },
      ),
    );
  }

  //if you don't want widget full screen then use center widget

  @override
  Widget build(BuildContext context) {
    Widget smallImage() => FullScreenWidget(
      child: Center(
        child: Hero(
          tag: "smallImage",
          child: FutureBuilder<List<allbranch>>(
            future: _fetchallbranch(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<allbranch> data = snapshot.data;
                return Grid(context, data);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: LightColor.red,
          title: Text("Photo Gallery"),
        ),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: smallImage(),
        ),
      ),
    );
  }
}