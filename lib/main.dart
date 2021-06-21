import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questry/app/modules/home/home_page.dart';
// import './app/routes/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xff2e3b5b),
          accentColor: Color(0xff2e3b5b),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold))),
      home: HomePage(),
    );
  }
}
