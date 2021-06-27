import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questry/app/modules/authentication/views/sign_-in_page.dart';
import 'package:questry/app/modules/authentication/views/sign_up_page.dart';
import 'package:questry/app/modules/feed/views/feedScreen.dart';
import 'package:questry/app/modules/home/loading_page.dart';
import './app/routes/app_pages.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = LoadingPage();
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String token = await storage.read(key: "token");
    print(token);
    if (token != null) {
      setState(() {
        page = FeedScreen();
      });
    } else {
      setState(() {
        page = GMSignUpPage();
      });
    }
  }

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
      home: page,
      getPages: AppPages.pages,
    );
  }
}
