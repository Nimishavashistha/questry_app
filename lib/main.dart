import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questry/app/modules/authentication/bindings/auth_binding.dart';
import 'package:questry/app/modules/authentication/views/sign_-in_page.dart';
import 'package:questry/app/modules/authentication/views/sign_up_page.dart';
import 'package:questry/app/modules/chatbox/views/chatpage.dart';
import 'package:questry/app/modules/feed/binding/feed_binding.dart';
import 'package:questry/app/modules/home/bindings/home_binding.dart';
import 'package:questry/app/modules/home/homepage.dart';
import 'package:questry/app/modules/profile/bindings/profile_binding.dart';
import './app/routes/app_pages.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/modules/authentication/controller/auth_controller.dart';
import 'app/modules/chatbox/controller/chatController.dart';
import 'app/modules/feed/controller/feed_controller.dart';
import 'app/modules/profile/controller/profile_controller.dart';

void main() {
  runApp(MyApp());
}

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedController>(() => FeedController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<ChatController>(() => ChatController(), fenix: true);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = FlutterSecureStorage();
  Widget page;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String token = await storage.read(key: "token");
    print("inside checklogin");
    // final prefs = await SharedPreferences.getInstance();
    // final key = 'token';
    // final token = prefs.getString(key);
    print(token);
    if (token != null) {
      setState(() {
        page = HomePage();
      });
    } else {
      setState(() {
        page = SignInPage();
      });
    }
    print("inside checkToken: $page");
  }

  Widget build(BuildContext context) {
    print("inside build $page");
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
        // initialRoute: AppRoutes.signin,
        home: SignInPage(),
        getPages: AppPages.pages,
        initialBinding: InitialBinding());
  }
}
