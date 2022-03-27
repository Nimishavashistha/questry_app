import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questry/app/constants/colors.dart';
import 'package:questry/app/modules/authentication/controller/auth_controller.dart';
import 'package:questry/app/modules/chatbox/controller/chatController.dart';
import 'package:questry/app/modules/profile/controller/profile_controller.dart';
import 'package:questry/app/modules/profile/views/pages/posts.dart';
import 'package:questry/app/routes/routes_management.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 25,
            fontWeight: FontWeight.bold),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: primaryColor,
            child: Container(
              width: double.infinity,
              height: 180,
              child: Container(
                alignment: Alignment(0.0, 2.5),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                  radius: 60.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.wifi,
                color: Colors.black,
                size: 23,
              ),
              label: Text(
                "Feed",
                style: TextStyle(color: Colors.black, fontSize: 18),
              )),
          GetBuilder<ChatController>(
              builder: (controller) => GetBuilder<ProfileController>(
                  builder: (profilecontroller) => TextButton.icon(
                      onPressed: () async {
                        if (controller.getConv == false) {
                          await controller.getConversations(
                              profilecontroller.profileModel.id);
                        }
                        RoutesManagement.goToChatPage();
                      },
                      icon: Icon(
                        Icons.message,
                        color: Colors.black,
                        size: 23,
                      ),
                      label: Text(
                        "Talks",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      )))),
          TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.photo,
                color: Colors.black,
                size: 23,
              ),
              label: Text(
                "Photos",
                style: TextStyle(color: Colors.black, fontSize: 18),
              )),
          TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.group,
                color: Colors.black,
                size: 23,
              ),
              label: Text(
                "Groups",
                style: TextStyle(color: Colors.black, fontSize: 18),
              )),
          TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.bookmark,
                color: Colors.black,
                size: 23,
              ),
              label: Text(
                "BookMarks",
                style: TextStyle(color: Colors.black, fontSize: 18),
              )),
          TextButton.icon(
              onPressed: () {
                RoutesManagement.goToMyPostsPage();
              },
              icon: Icon(
                Icons.question_answer_sharp,
                color: Colors.black,
                size: 23,
              ),
              label: Text(
                "My Posts",
                style: TextStyle(color: Colors.black, fontSize: 18),
              )),
          TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.event,
                color: Colors.black,
                size: 23,
              ),
              label: Text(
                "Events",
                style: TextStyle(color: Colors.black, fontSize: 18),
              )),
          TextButton.icon(
              onPressed: () {
                RoutesManagement.goToEditProfilePage();
              },
              icon: Icon(
                Icons.edit_attributes,
                color: Colors.black,
                size: 23,
              ),
              label: Text(
                "Edit Profile",
                style: TextStyle(color: Colors.black, fontSize: 18),
              )),
          GetBuilder<AuthController>(
              builder: (authcontroller) => TextButton.icon(
                  onPressed: () async {
                    await authcontroller.logout();
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.black,
                    size: 23,
                  ),
                  label: Text(
                    "Logout",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )))
        ],
      ),
    );
  }
}
