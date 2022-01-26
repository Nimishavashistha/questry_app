import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questry/app/constants/colors.dart';
import 'package:questry/app/global_widgets/drawer.dart';
import 'package:questry/app/modules/chatbox/controller/chatController.dart';
import 'package:questry/app/modules/chatbox/views/chatpage.dart';
import 'package:questry/app/modules/profile/controller/profile_controller.dart';
import 'package:questry/app/routes/routes_management.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage(this.cameFromChat);
  final bool cameFromChat;

  @override
  Widget build(BuildContext context) {
    print("cameFromChat value is: $cameFromChat");
    return GetBuilder<ProfileController>(
        builder: (controller) => Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: SafeArea(
              child: controller.circular
                  ? Center(child: CircularProgressIndicator())
                  : ListView(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://images.unsplash.com/photo-1549778399-f94fd24d4697?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8NTh8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
                                  fit: BoxFit.cover)),
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 160,
                                child: Container(
                                  alignment: Alignment(0.0, 2.5),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                                    radius: 60.0,
                                  ),
                                ),
                              ),
                              cameFromChat
                                  ? Container()
                                  : Positioned(
                                      bottom: 0,
                                      right: 120.0,
                                      child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              width: 4,
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                            ),
                                            color: primaryColor,
                                          ),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              RoutesManagement
                                                  .goToEditProfilePage();
                                            },
                                          )))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cameFromChat
                                  ? controller.profileModel2.username
                                  : controller.profileModel.username,
                              style: TextStyle(
                                  fontSize: 25.0,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              cameFromChat
                                  ? controller.profileModel2.from
                                  : controller.profileModel.from,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              cameFromChat
                                  ? controller.profileModel2.desc
                                  : controller.profileModel.desc,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding:
                                const EdgeInsets.only(top: 12.0, bottom: 12.0),
                            width: double.infinity,
                            color: Colors.grey.shade300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "15",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "answers",
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "200",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Questions",
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "2k",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Followers",
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "300",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Following",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        cameFromChat
                            ? Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          print(
                                              "inside chat button: ${controller.profileModel.id}");
                                          RoutesManagement.goToChatPage();
                                        },
                                        child: Text(
                                          "chat",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ))),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
            )));
  }

  Widget bottomSheet(BuildContext context) {
    return Expanded(
      child: Container(
        height: 130,
        width: MediaQuery.of(context).size.width,
        child: Card(
          margin: EdgeInsets.all(18),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                iconCreation(
                    Icons.insert_drive_file, Colors.indigo, "Document"),
                SizedBox(
                  width: 26,
                ),
                iconCreation(Icons.photo_library, Colors.deepOrangeAccent,
                    "Photo or video"),
                SizedBox(
                  width: 26,
                ),
                iconCreation(Icons.location_pin, Colors.green, "Location"),
                SizedBox(
                  width: 26,
                ),
                iconCreation(
                    Icons.emoji_emotions, Colors.amber, "Achievements"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 20,
            child: Icon(
              icon,
              size: 18,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
