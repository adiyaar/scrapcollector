import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:myscrapcollector/screen/homepage/home_header.dart';
import 'package:myscrapcollector/screen/homepage/home_joinus_view.dart';
import 'package:myscrapcollector/theme/light_color.dart';
import 'package:myscrapcollector/widgets/custom_divider_view.dart';
import 'home_pricelist.dart';

class SliderPage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(height: 200),
            child: SliderDemo(),
          ),
          BestInSafetyViews(),
          FutureBuilder<List<Job1>>(
            future: fetchJobs(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Job1> data = snapshot.data;

                return imageSlider1(context, data);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(LightColor.red),


              ));
            },
          ),
          //CustomDividerView(),
          joinusview(),
        ]),
      ],
    );
  }
}

class Job {
  final String url;

  Job({
    this.url,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      url: json['img'],
    );
  }
}

class SliderDemo extends StatelessWidget {
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
              valueColor: AlwaysStoppedAnimation<Color>(LightColor.red),
            ));
      },
    );
  }

  Future<List<Job>> _fetchJobs() async {
    final jobsListAPIUrl =
        'http://myscrapcollector.com/beta/api/api.php?get_banner';
    final response = await http.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

Swiper imageSlider(context, data) {
  return new Swiper(
    autoplay: true,
    itemCount: data.length,
    itemBuilder: (BuildContext context, int index) {
      return new Image.network(
        'http://myscrapcollector.com/beta/admin/images/slider/' +
            data[index].url,
        fit: BoxFit.fitWidth,
        width: 300,
      );
    },

    //viewportFraction: 0.2,

    scale: 1.0,
  );
}
