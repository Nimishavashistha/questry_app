import 'package:flutter/material.dart';
import 'package:questry/app/constants/colors.dart';
import 'package:questry/app/data/addpostModel.dart';
import 'package:get/get.dart';
import 'package:questry/app/modules/authentication/controller/auth_controller.dart';
import 'package:questry/app/modules/feed/controller/feed_controller.dart';
import 'package:questry/app/modules/profile/controller/profile_controller.dart';

class FeedScreen extends StatelessWidget {
  final String questionStmt;
  final String time;
  final int noOfResponses;

  const FeedScreen({Key key, this.questionStmt, this.time, this.noOfResponses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: GetBuilder<FeedController>(
          builder: (controller) => ListView(
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    height: 70.0,
                    width: double.infinity,
                    color: primaryColor,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F5F7),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.search,
                            ),
                            title: TextField(
                              decoration: InputDecoration(
                                  hintText: "search for anything",
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFFA0A5BD),
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: controller.data
                    .map((item) => post(
                          addPostModel: item,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class post extends StatelessWidget {
  final AddPostModel addPostModel;
  const post({
    Key key,
    this.addPostModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => SafeArea(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(10.0),
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "5 min ago",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              addPostModel.desc,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15.0),
                              child: addPostModel.img != ""
                                  ? Image(
                                      image:
                                          controller.getImage(addPostModel.id),
                                    )
                                  : Container(),
                            )
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Answer",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ))),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 8.0),
              width: double.infinity,
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "4 Answers",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Paul Graham",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Founder of Y-Combinator",
                                style: TextStyle(color: Colors.black54),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Cras mattis consecteturer purus set amet fermentum.Aenan lacinia bibendum nulla sed consecturer.Macenas fucibus mollis "
                        "interdum. Cum soccis natoque penathosis et magnis dis partueuioe ,niosuygs",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 5.0),
                      child: Text(
                        "1.4k Views",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    ImageIcon(
                                      AssetImage("assets/images/arrow-up.png"),
                                      color: primaryColor,
                                      size: 26,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Container(
                                        height: 26,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 1)),
                                      ),
                                    ),
                                    ImageIcon(
                                      AssetImage(
                                          "assets/images/down-arrow.png"),
                                      color: primaryColor.withOpacity(0.4),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                IconButton(
                                    iconSize: 33,
                                    icon: Icon(
                                      Icons.comment,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {}),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: CircleAvatar(
                                      backgroundColor: primaryColor,
                                      radius: 10,
                                      child: Text(
                                        "2",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "answered",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Nov 11'20 at 12:33",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            GetBuilder<AuthController>(
              builder: (controller) => ListTile(
                tileColor: Colors.grey.shade300,
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        controller: controller.comment,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              controller.addComment();
                            },
                          ),
                          hintText: "Add your answer...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
//              trailing: TextButton(
//                child: Icon(Icons.send),
//                onPressed: () {},
//              ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              color: Colors.grey.shade300,
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
