import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:myscrapcollector/theme/light_color.dart';

class Job1 {
  final String userId;
  final String title;
  final String img;
  final String description;
  final String qty;
  final String units;
  Job1(
      {this.userId,
      this.title,
      this.img,
      this.description,
      this.units,
      this.qty});
  factory Job1.fromJson(Map<String, dynamic> json) {
    return Job1(
      userId: json['userId'],
      title: json['title'],
      img: json['img'],
      description: json['description'],
      units: json['units'],
      qty: json['qty'],
    );
  }
}

imageSlider1(context, data) {

  return Container(
    height: (data.length / 3) * 70,
    // height: 150,

    child: GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2.2),
          crossAxisCount: 2),
      scrollDirection: Axis.horizontal,
      itemCount: data.length,


      itemBuilder: (context, index) {
        return Card(

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
        ]));
      },
    ),
  );
}
