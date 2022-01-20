import 'package:flutter/material.dart';
import 'package:questry/app/constants/colors.dart';
import 'package:questry/app/data/addpostModel.dart';
import 'package:get/get.dart';
import 'package:questry/app/data/commentModel.dart';
import 'package:questry/app/modules/feed/controller/feed_controller.dart';
import 'package:questry/app/modules/feed/views/pages/add_posts.dart';
import 'package:questry/app/modules/profile/controller/profile_controller.dart';
import 'package:questry/app/modules/profile/views/profile_page.dart';
import 'package:questry/app/routes/routes_management.dart';

class QuestionWithAnswerPage extends StatelessWidget {
  List arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    AddPostModel item = arguments[0];
    List<commentModel> comments = arguments[1];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.pop(Get.context);
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            post(
              addPostModel: item,
              comments: comments,
            )
          ],
        ),
      ),
    );
  }
}

class post extends StatelessWidget {
  final AddPostModel addPostModel;
  final List<commentModel> comments;
  const post({
    Key key,
    this.addPostModel,
    this.comments,
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
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 8.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       ElevatedButton(
                    //           onPressed: () {},
                    //           child: Text(
                    //             "Answer",
                    //             style: TextStyle(color: Colors.white),
                    //           ),
                    //           style: ElevatedButton.styleFrom(
                    //               primary: primaryColor,
                    //               shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(18.0),
                    //               ))),
                    //     ],
                    //   ),
                    // )
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
                  "${addPostModel.noOfanswers.length.toString()} Answers",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            GetBuilder<FeedController>(
              builder: (controller) => ListTile(
                tileColor: Colors.grey.shade300,
                // leading: CircleAvatar(
                //   backgroundColor: Colors.grey,
                //   child: Icon(
                //     Icons.person,
                //     color: Colors.white,
                //     size: 30,
                //   ),
                // ),
                trailing: ElevatedButton(
                    onPressed: () {
                      controller.UpdatingTotalNoOfAnswers(addPostModel.id);
                      controller.addComment(
                        addPostModel.id,
                      );
                    },
                    child: Text(
                      "Answer",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                title: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: controller.comment,
                      onChanged: (val) {
                        controller.changeEnteredMessage(val);
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.attach_file,
                            color: primaryColor,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                context: Get.context,
                                builder: (builder) => bottomSheet(Get.context));
                          },
                        ),
                        hintText: "Add your answer...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            comments == null
                ? CircularProgressIndicator()
                : GetBuilder<FeedController>(
                    builder: (feedcontroller) => Column(
                      children: comments
                          .map((comment) => CommentSection(
                                comment: comment,
                              ))
                          .toList(),
                    ),
                  ),
            SizedBox(
              height: 10,
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

class CommentSection extends StatelessWidget {
  final commentModel comment;
  const CommentSection({
    Key key,
    this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("inside comment postUserId=${comment.postUserId}");
    return GetBuilder<FeedController>(
      builder: (controller) => Container(
        margin: EdgeInsets.only(top: 15, bottom: 15),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: comment.userpic != ""
                        ? controller.getImage(comment.postUserId)
                        : Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GetBuilder<ProfileController>(
                          builder: (profilecontroller) => InkWell(
                            child: Text(
                              comment.userName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              if (comment.userName !=
                                  profilecontroller.profileModel.username) {
                                profilecontroller.fetchingSpacificUserProfile(
                                    comment.postUserId);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProfilePage(true)));
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProfilePage(false)));
                              }
                            },
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
                  comment.content,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.all(Radius.circular(18.0)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          comment.likes.length.toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.arrow_upward,
                              size: 26,
                            ),
                            color: ((controller.upvoted =
                                    comment.likes.length == 0 ? false : true)
                                ? primaryColor
                                : Colors.black),
                            onPressed: () async {
                              controller.upvoted =
                                  comment.likes.length == 0 ? false : true;
                              controller.downvoted =
                                  comment.dislikes.length == 0 ? false : true;
                              // print(
                              //     "before clicking up arrow_upward upvoted=${controller.upvoted}");
                              // print(
                              //     "before clicking up arrow_upward downvoted=${controller.downvoted}");
                              await controller.upvote(comment.id);
                            }),
                        Text(
                          comment.dislikes.length.toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.arrow_downward,
                              size: 26,
                            ),
                            color: ((controller.downvoted =
                                    comment.dislikes.length == 0 ? false : true)
                                ? primaryColor
                                : Colors.black),
                            onPressed: () async {
                              controller.upvoted =
                                  comment.likes.length == 0 ? false : true;
                              controller.downvoted =
                                  comment.dislikes.length == 0 ? false : true;
                              // print(
                              //     "before clicking up arrow_downward upvoted=${controller.upvoted}");
                              // print(
                              //     "before clicking up arrow_downward downvoted=${controller.downvoted}");
                              await controller.downvote(comment.id);
                            }),
                        // ImageIcon(
                        //   AssetImage("assets/images/arrow-up.png"),
                        //   color: primaryColor,
                        //   size: 26,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 8.0, right: 8.0),
                        //   child: Container(
                        //     height: 26,
                        //     decoration: BoxDecoration(
                        //         border: Border.all(width: 1)),
                        //   ),
                        // ),
                        // ImageIcon(
                        //   AssetImage("assets/images/down-arrow.png"),
                        //   color: primaryColor.withOpacity(0.4),
                        // ),
                      ],
                    ),
                  ),
                  IconButton(
                      iconSize: 33,
                      icon: Icon(
                        Icons.reply_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {}),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
