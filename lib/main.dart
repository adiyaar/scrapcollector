import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myscrapcollector/splash_screen.dart';

import 'shared/app_theme.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Scrap Collector',
      debugShowCheckedModeBanner: false,
      theme: appPrimaryTheme(),
      home: SplashScreen(),
    );
  }
}
