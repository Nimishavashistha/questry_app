import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questry/app/constants/colors.dart';
import 'package:questry/app/data/addpostModel.dart';
import 'package:questry/app/modules/feed/controller/feed_controller.dart';
import 'package:questry/app/modules/profile/controller/profile_controller.dart';
import 'package:questry/app/routes/routes_management.dart';

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("My Posts",
              style: TextStyle(
                fontSize: 20,
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
    // print("inside post widget");
    // print("noOfAnswers = ${addPostModel.noOfanswers.length}");
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
                    GetBuilder<FeedController>(
                        builder: (feedController) => Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        await feedController
                                            .fetchComments(addPostModel.id);

                                        RoutesManagement.goToQuestAnsPage(
                                            addPostModel,
                                            feedController.comments);
                                      },
                                      child: Text(
                                        "Answer",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ))),
                                  Stack(
                                    children: [
                                      IconButton(
                                          iconSize: 33,
                                          icon: Icon(
                                            Icons.comment_rounded,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () async {
                                            await feedController
                                                .fetchComments(addPostModel.id);

                                            RoutesManagement.goToQuestAnsPage(
                                                addPostModel,
                                                feedController.comments);
                                          }),
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        child: CircleAvatar(
                                            backgroundColor: primaryColor,
                                            radius: 10,
                                            child: Text(
                                              addPostModel.noOfanswers.length
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            )),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18.0)),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              addPostModel.likes.length
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.arrow_upward,
                                                  size: 26,
                                                ),
                                                color:
                                                    (feedController.postupvoted
                                                        ? primaryColor
                                                        : Colors.black),
                                                onPressed: () async {
                                                  await feedController
                                                      .PostUpvote(
                                                          addPostModel.id);
                                                }),

                                            IconButton(
                                                icon: Icon(
                                                  Icons.arrow_downward,
                                                  size: 26,
                                                ),
                                                color: (feedController
                                                        .postdownvoted
                                                    ? primaryColor
                                                    : Colors.black),
                                                onPressed: () async {
                                                  await feedController
                                                      .PostDownvote(
                                                          addPostModel.id);
                                                }),
                                            // ImageIcon(
                                            //   AssetImage(
                                            //       "assets/images/arrow-up.png"),
                                            //   color: primaryColor,
                                            //   size: 26,
                                            // ),
                                            // Padding(
                                            //   padding: const EdgeInsets.only(
                                            //       left: 8.0, right: 8.0),
                                            //   child: Container(
                                            //     height: 26,
                                            //     decoration: BoxDecoration(
                                            //         border:
                                            //             Border.all(width: 1)),
                                            //   ),
                                            // ),
                                            // ImageIcon(
                                            //   AssetImage(
                                            //       "assets/images/down-arrow.png"),
                                            //   color:
                                            //       primaryColor.withOpacity(0.4),
                                            // ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ])))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
