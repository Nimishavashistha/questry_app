import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questry/app/constants/colors.dart';
import 'package:questry/app/data/addpostModel.dart';
import 'package:questry/app/modules/profile/controller/profile_controller.dart';

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("My Posts",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Raleway",
              )),
        ),
        body: GetBuilder<ProfileController>(
          builder: (controller) => controller.data == null
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  children: controller.data
                      .map((item) => post(
                            addPostModel: item,
                          ))
                      .toList(),
                ),
        ));
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
            ListTile(
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
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.send),
                        hintText: "Add a Comment...",
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
