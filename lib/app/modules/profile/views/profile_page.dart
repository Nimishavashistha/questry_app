import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questry/app/constants/colors.dart';
import 'package:questry/app/global_widgets/drawer.dart';
import 'package:questry/app/modules/profile/controller/profile_controller.dart';
import 'package:questry/app/routes/routes_management.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        builder: (controller) => Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: Text(
                "Questry",
                style: Theme.of(context).textTheme.headline6,
              ),
              actions: [
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
              ],
            ),
            drawer: MainDrawer(),
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
                              Positioned(
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
                                        RoutesManagement.goToEditProfilePage();
                                      },
                                    ),
                                  ))
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
                              controller.profileModel.username,
                              style: TextStyle(
                                  fontSize: 25.0,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              controller.profileModel.from,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              controller.profileModel.desc,
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 190,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40.0),
                                      child: TextField(
                                          decoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                                              ),
                                            ),
                                            labelText: "What's your doubt?",
                                            labelStyle: TextStyle(
                                              fontSize: 17,
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(Icons.attach_file),
                                              onPressed: () {
                                                showModalBottomSheet(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (builder) =>
                                                        bottomSheet(context));
                                              },
                                            ),
                                          ),
                                          onSubmitted: (_) => () {}),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: primaryColor,
                                          ),
                                          child: Text(
                                            "Post",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {}),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
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
