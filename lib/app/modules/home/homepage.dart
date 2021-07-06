import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:questry/app/constants/colors.dart';
import 'package:questry/app/global_widgets/drawer.dart';
import 'package:questry/app/modules/feed/views/feedScreen.dart';
import 'package:questry/app/modules/profile/controller/profile_controller.dart';
import 'package:questry/app/modules/profile/views/profile_page.dart';
import 'package:questry/app/routes/routes_management.dart';

class HomePage extends StatelessWidget {
  List<Widget> widgets = [FeedScreen(), ProfilePage()];
  List<String> titleString = ["Questry", "Profile Page"];
  // final storage = FlutterSecureStorage();
  // String username = "";
  // Widget profilePhoto = Container(
  //   height: 100,
  //   width: 100,
  //   decoration: BoxDecoration(
  //     color: Colors.black,
  //     borderRadius: BorderRadius.circular(50),
  //   ),
  // );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: primaryColor,
            title: Text(
              titleString[controller.currentIndex],
            ),
            centerTitle: true,
            actions: <Widget>[
              Stack(
                children: [
                  IconButton(
                      iconSize: 28,
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                      onPressed: () {}),
                  Positioned(
                    top: 2,
                    right: 4,
                    child: CircleAvatar(
                        radius: 9,
                        backgroundColor: Colors.red,
                        child: Text(
                          "7",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )),
                  )
                ],
              )
            ]),
        drawer: MainDrawer(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            RoutesManagement.goToAddPostsPage();
          },
          child: Text(
            "+",
            style: TextStyle(fontSize: 25),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: primaryColor,
          elevation: 0,
          // shape: CircularNotchedRectangle(),
          // notchMargin: 12,
          child: Container(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.home),
                    color: controller.currentIndex == 0
                        ? Colors.white
                        : Colors.white54,
                    onPressed: () {
                      controller.setCurrentIndexToZero();
                    },
                    iconSize: 30,
                  ),
                  IconButton(
                    icon: Icon(Icons.person),
                    color: controller.currentIndex == 1
                        ? Colors.white
                        : Colors.white54,
                    onPressed: () {
                      controller.setCurrentIndexToOne();
                    },
                    iconSize: 30,
                  )
                ],
              ),
            ),
          ),
        ),
        body: widgets[controller.currentIndex],
      ),
    );
  }
}
