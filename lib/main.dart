import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pincodefieldsdemo/home.dart';

void main() {
  runApp(MyApp());
  initStatusBar();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage("0988123123"),
    );
  }
}

void initStatusBar() {
  // statusBarColor: 控制背景色值
  // statusBarIconBrightness: 控制本文色值
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.red, statusBarIconBrightness: Brightness.light);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}
