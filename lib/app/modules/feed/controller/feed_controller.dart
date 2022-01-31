import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:questry/app/constants/colors.dart';
import 'package:questry/app/data/User.dart';
import 'package:questry/app/data/addpostModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:questry/app/data/commentModel.dart';
import 'package:questry/app/data/commentSuperModel.dart';
import 'package:questry/app/data/superModel.dart';
import 'package:questry/app/modules/home/homepage.dart';

class FeedController extends GetxController {
  final globalkey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController comment = TextEditingController();
  ImagePicker picker = ImagePicker();
  PickedFile imageFile;
  IconData iconphoto = Icons.image;
  FlutterSecureStorage storage = FlutterSecureStorage();
  SuperModel superModel;
  CommentSuperModel commentSuperModel;
  List<AddPostModel> data = [];
  String baseurl = "http://10.0.2.2:8800";
  User user = User('', '');
  var enteredMessage = "";
  List<commentModel> comments = [];
  var upvoted = false;
  var downvoted = false;
  var postupvoted = false;
  var postdownvoted = false;
  List likes = [];
  List dislikes = [];
  var url;

  Future<http.StreamedResponse> patchImage(String url, String filepath) async {
    String token = await storage.read(key: "token");
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("file", filepath));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer $token",
    });
    var response = request.send();
    return response;
  }

  @override
  void onInit() async {
    await fetchOtherPosts();
    super.onInit();
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.getImage(
      source: source,
    );
    imageFile = pickedFile;
    update();
  }

  Future<void> fetchOtherPosts() async {
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/posts/getOtherPost/");
    var response = await http.get(
      url,
      headers: <String, String>{"Authorization": "Bearer $token"},
    );
    // print("response = ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("inside fetchpostsdata");
      superModel = SuperModel.fromJson(json.decode(response.body));
      data = superModel.data;
      update();
    }
    print("data=$data");
  }

  Future<void> fetchComments(String postId) async {
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/comment/getComments/$postId");
    var response = await http.get(
      url,
      headers: <String, String>{"Authorization": "Bearer $token"},
    );
    // print(json.decode(response.body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("inside fetchcomments");
      commentSuperModel =
          CommentSuperModel.fromJson(json.decode(response.body));
      comments = commentSuperModel.data;
      update();
      // print("length=${comments.length}");
    }
    // comments.map((comment) {
    //   downvoted = comment.dislikes.length == 0 ? false : true;
    //   update();
    //   upvoted = comment.likes.length == 0 ? false : true;
    //   update();
    // }).toList();
    // print("comments=$comments");
  }

  String formater(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String imageName) {
    // print("imageName = $imageName");
    String url = formater("/uploads//$imageName.jpg");
    return NetworkImage(url);
  }

  void submit() async {
    if (globalkey.currentState.validate()) {
      print("isnide submit fun");
      print(desc.text);
      String token = await storage.read(key: "token");
      var url = Uri.parse("http://10.0.2.2:8800/api/posts");
      // AddPostModel addPostModel = AddPostModel(desc: desc.text);
      // print(addPostModel.toJson());
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(<String, String>{
            "desc": desc.text,
          }));
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        desc.clear();
        if (imageFile.path != null) {
          String id = json.decode(response.body)["data"];
          var url = "http://10.0.2.2:8800/api/posts/add/img/$id";
          var imageResponse = patchImage(url, imageFile.path);
          Get.showSnackbar(
            GetBar(
              backgroundColor: primaryColor,
              message: "your Doubt added Successfully",
              isDismissible: true,
            ),
          );
          await fetchOtherPosts();
          Get.offAll(() => HomePage());
        } else {
          Get.showSnackbar(
            GetBar(
              backgroundColor: primaryColor,
              message: "your Doubt added Successfully",
              isDismissible: true,
            ),
          );
          await fetchOtherPosts();
          Get.offAll(() => HomePage());
        }
      }
      Get.offAll(() => HomePage());
    }
  }

  void changeEnteredMessage(value) {
    enteredMessage = value;
    update();
  }

  //adding a comment to the post

  void addComment(postId) async {
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/comment/");
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(<String, String>{
          "content": enteredMessage,
          "_id": postId,
        }));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("inside add comments function");
      print(response.body);
      comment.clear();
      await fetchComments(postId);
      await fetchOtherPosts();
      Get.showSnackbar(
        GetBar(
          backgroundColor: primaryColor,
          message: "your answer added",
          isDismissible: true,
        ),
      );
    }
    // Get.offAll(() => HomePage());
  }

  Future<void> upvote(String commentId) async {
    // print("feedcontroller.upvoted=$upvoted");
    // print("feedcontroller.downvoted=$downvoted");
    if (upvoted) {
      await undoUpvote(commentId);
      return;
    }
    if (downvoted) {
      await undoDownvote(commentId);
      // return;
    }
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/comment/upvotes");
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(<String, String>{
          "commentId": commentId,
        }));

    if (response.statusCode == 200 || response.statusCode == 201) {
      upvoted = true;
      update();
      var id = json.decode(response.body)['_id'];
      print("inside upvotes id= $id");
      comments.map((comment) {
        if (comment.id == id) {
          comment.likes = json.decode(response.body)['likes'];
          update();
        }
      }).toList();
      // print("inside upvote $likes");
    }
  }

  Future<void> undoUpvote(String commentId) async {
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/comment/undoUpvotes");
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(<String, String>{
          "commentId": commentId,
        }));

    if (response.statusCode == 200 || response.statusCode == 201) {
      upvoted = false;
      update();
      var id = json.decode(response.body)['_id'];
      print("inside undoUpvotes id= $id");
      comments.map((comment) {
        if (comment.id == id) {
          comment.likes = json.decode(response.body)['likes'];
          update();
        }
      }).toList();
    }
  }

  Future<void> downvote(String commentId) async {
    // print("feedcontroller.upvoted=$upvoted");
    // print("feedcontroller.downvoted=$downvoted");
    if (downvoted) {
      await undoDownvote(commentId);
      return;
    }
    if (upvoted) {
      await undoUpvote(commentId);
    }
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/comment/downvotes");
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(<String, String>{
          "commentId": commentId,
        }));

    if (response.statusCode == 200 || response.statusCode == 201) {
      downvoted = true;
      update();
      var id = json.decode(response.body)['_id'];
      print("inside undoUpvotes id= $id");
      comments.map((comment) {
        if (comment.id == id) {
          comment.dislikes = json.decode(response.body)['dislikes'];
          update();
        }
      }).toList();
    }
  }

  Future<void> undoDownvote(String commentId) async {
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/comment/undoDownvotes");
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(<String, String>{
          "commentId": commentId,
        }));

    if (response.statusCode == 200 || response.statusCode == 201) {
      downvoted = false;
      update();
      var id = json.decode(response.body)['_id'];
      print("inside undoUpvotes id= $id");
      comments.map((comment) {
        if (comment.id == id) {
          comment.dislikes = json.decode(response.body)['dislikes'];
          update();
        }
      }).toList();
    }
  }

  Future<void> UpdatingTotalNoOfAnswers(String postId) async {
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/posts/noOfAnswers");
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(<String, String>{
          "postId": postId,
        }));

    // if (response.statusCode == 200 || response.statusCode == 201) {

    // }
  }

  Future<void> PostUpvote(String postId) async {
    // print("feedcontroller.upvoted=$upvoted");
    // print("feedcontroller.downvoted=$downvoted");
    print("inside postUpvote");
    if (postupvoted) {
      await undoPostUpvote(postId);
      return;
    }
    if (postdownvoted) {
      await undoPostDownvote(postId);
      // return;
    }
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/posts/upvotes");
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(<String, String>{
          "postId": postId,
        }));

    if (response.statusCode == 200 || response.statusCode == 201) {
      postupvoted = true;
      update();
      var id = json.decode(response.body)['_id'];
      // print("inside upvotes id= $id");
      data.map((post) {
        if (post.id == id) {
          post.likes = json.decode(response.body)['likes'];
          update();
        }
      }).toList();
      // print("after clicking up arrow_upward upvoted=${postupvoted}");
      // print("after clicking up arrow_upward downvoted=${postdownvoted}");
    }
  }

  Future<void> undoPostUpvote(String postId) async {
    print("inside undoPostUpvote");
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/posts/undoUpvotes");
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(<String, String>{
          "postId": postId,
        }));

    if (response.statusCode == 200 || response.statusCode == 201) {
      postupvoted = false;
      update();
      var id = json.decode(response.body)['_id'];
      // print("inside undoUpvotes id= $id");
      data.map((post) {
        if (post.id == id) {
          post.likes = json.decode(response.body)['likes'];
          update();
        }
      }).toList();
    }
  }

  Future<void> PostDownvote(String postId) async {
    print("inside postDownvotes");
    // print("feedcontroller.upvoted=$upvoted");
    // print("feedcontroller.downvoted=$downvoted");
    if (postdownvoted) {
      await undoPostDownvote(postId);
      return;
    }
    if (postupvoted) {
      await undoPostUpvote(postId);
    }
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/posts/downvotes");
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(<String, String>{
          "postId": postId,
        }));

    if (response.statusCode == 200 || response.statusCode == 201) {
      postdownvoted = true;
      update();
      var id = json.decode(response.body)['_id'];
      // print("inside undoUpvotes id= $id");
      data.map((post) {
        if (post.id == id) {
          post.dislikes = json.decode(response.body)['dislikes'];
          update();
        }
      }).toList();
    }
    // print("after clicking up arrow_upward upvoted=${postupvoted}");
    // print("after clicking up arrow_upward downvoted=${postdownvoted}");
  }

  Future<void> undoPostDownvote(String postId) async {
    print("insdie undoPostDownVote");
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/posts/undoDownvotes");
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(<String, String>{
          "postId": postId,
        }));
    // print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      postdownvoted = false;
      update();
      var id = json.decode(response.body)['_id'];
      // print("inside undoPostDownvotes id= $id");
      data.map((post) {
        if (post.id == id) {
          post.dislikes = json.decode(response.body)['dislikes'];
          update();
        }
      }).toList();
    }
    // print("after clicking up arrow_upward upvoted=${postupvoted}");
    // print("after clicking up arrow_upward downvoted=${postdownvoted}");
  }
}
