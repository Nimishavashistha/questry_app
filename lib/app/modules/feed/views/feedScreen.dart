import 'package:flutter/material.dart';
import 'package:questry/app/constants/colors.dart';
import 'package:questry/app/data/addpostModel.dart';
import 'package:get/get.dart';
import 'package:questry/app/modules/feed/controller/feed_controller.dart';
import 'package:questry/app/modules/profile/controller/profile_controller.dart';
import 'package:questry/app/routes/routes_management.dart';

class FeedScreen extends StatelessWidget {
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
                            leading: IconButton(
                              icon: Icon(
                                Icons.search,
                              ),
                              onPressed: () {
                                // print(controller.data);
                              },
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
              controller.data == null
                  ? Center(child: CircularProgressIndicator())
                  : Column(
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
                                                color: ((feedController
                                                            .postupvoted =
                                                        addPostModel.likes
                                                                    .length ==
                                                                0
                                                            ? false
                                                            : true)
                                                    ? primaryColor
                                                    : Colors.black),
                                                onPressed: () async {
                                                  feedController.postupvoted =
                                                      addPostModel.likes
                                                                  .length ==
                                                              0
                                                          ? false
                                                          : true;
                                                  feedController.postdownvoted =
                                                      addPostModel.dislikes
                                                                  .length ==
                                                              0
                                                          ? false
                                                          : true;
                                                  // print(
                                                  //     "before clicking up arrow_upward upvoted=${feedController.postupvoted}");
                                                  // print(
                                                  //     "before clicking up arrow_upward downvoted=${feedController.postdownvoted}");
                                                  await feedController
                                                      .PostUpvote(
                                                          addPostModel.id);
                                                }),
                                            Text(
                                              addPostModel.dislikes.length
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.arrow_downward,
                                                  size: 26,
                                                ),
                                                color: ((feedController
                                                            .postdownvoted =
                                                        addPostModel.dislikes
                                                                    .length ==
                                                                0
                                                            ? false
                                                            : true)
                                                    ? primaryColor
                                                    : Colors.black),
                                                onPressed: () async {
                                                  feedController.postupvoted =
                                                      addPostModel.likes
                                                                  .length ==
                                                              0
                                                          ? false
                                                          : true;
                                                  feedController.postdownvoted =
                                                      addPostModel.dislikes
                                                                  .length ==
                                                              0
                                                          ? false
                                                          : true;
                                                  // print(
                                                  //     "before clicking up arrow_downward upvoted=${feedController.postupvoted}");
                                                  // print(
                                                  //     "before clicking up arrow_downward downvoted=${feedController.postdownvoted}");
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
