import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:myscrapcollector/theme/light_color.dart';

class SummerItems extends StatefulWidget {
  @override
  _SummerItemsState createState() => _SummerItemsState();
}

class _SummerItemsState extends State<SummerItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SummerItemsDemo(),
    );
  }
}

class Job {
  final String userId;
  final String title;
  final String img;
  final String description;
  Job({
    this.userId,
    this.title,
    this.img,
    this.description
  });
  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      userId: json['userId'],
      title: json['title'],
      img: json['img'],
      description: json['description'],
    );
  }
}

class SummerItemsDemo extends StatelessWidget {
  //List data;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Job>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Job> data = snapshot.data;
          return imageSlider(context, data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(
            child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
        ));
      },
    );
  }

  Future<List<Job>> _fetchJobs() async {
    final jobsListAPIUrl =
        'http://myscrapcollector.com/beta/api/api.php?get_products';
    final response = await http.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

imageSlider(context, data) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 1.28),
        crossAxisCount: 2),

    itemCount: data.length,
    itemBuilder: (context, index) {
      return Card(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
                width: 120,
                height: 150,
                child: new Image.network(
                  'http://myscrapcollector.com/beta/admin/images/products/' +
                      data[index].img,
                  fit: BoxFit.fitWidth,
                  width: 100,
                )),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: Text(
                data[index].title,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              data[index].description,
              maxLines: 2,
              style: TextStyle( fontSize: 13.0),
              overflow: TextOverflow.ellipsis,
            ),
          ]));
    },
  );
}
