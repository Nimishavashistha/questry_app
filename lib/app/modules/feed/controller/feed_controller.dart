import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:questry/app/data/addpostModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:questry/app/data/superModel.dart';
import 'package:questry/app/modules/home/homepage.dart';

class FeedController extends GetxController {
  final globalkey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  ImagePicker picker = ImagePicker();
  PickedFile imageFile;
  IconData iconphoto = Icons.image;
  FlutterSecureStorage storage = FlutterSecureStorage();
  SuperModel superModel;
  List<AddPostModel> data = [];
  String baseurl = "http://10.0.2.2:8800";

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
  void onInit() {
    fetchOtherPosts();
    super.onInit();
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.getImage(
      source: source,
    );
    imageFile = pickedFile;
    update();
  }

  void fetchOtherPosts() async {
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/posts/getOtherPost/");
    var response = await http.get(
      url,
      headers: <String, String>{"Authorization": "Bearer $token"},
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("inside fetchpostsdata");
      superModel = SuperModel.fromJson(json.decode(response.body));
      data = superModel.data;
      update();
    }
  }

  String formater(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String imageName) {
    print("imageName = $imageName");
    String url = formater("/uploads//$imageName.jpg");
    return NetworkImage(url);
  }

  void submit() async {
    if (globalkey.currentState.validate()) {
      print("isnide submit fun");
      print(desc.text);
      String token = await storage.read(key: "token");
      var url = Uri.parse("http://10.0.2.2:8800/api/posts");
      AddPostModel addPostModel = AddPostModel(desc: desc.text);
      print(addPostModel.toJson());
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
        if (imageFile.path != null) {
          String id = json.decode(response.body)["data"];
          var url = "http://10.0.2.2:8800/api/posts/add/img/$id";
          var imageResponse = patchImage(url, imageFile.path);
          print(imageResponse);
          Get.offAll(() => HomePage());
        }
      }
      Get.offAll(() => HomePage());
    }
  }
}
