import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:questry/app/modules/feed/views/feedScreen.dart';
import 'dart:convert';

class ProfileController extends GetxController {
  final globalKey = GlobalKey<FormState>();
  TextEditingController semester = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController about = TextEditingController();
  PickedFile imageFile;
  final ImagePicker _picker = ImagePicker();
  bool circular = false;

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    imageFile = pickedFile;
    update();
  }

  Future submit() async {
    circular = true;
    update();
    if (globalKey.currentState.validate()) {
      var url = Uri.parse("http://10.0.2.2:8800/api/users/add/profile");
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "sem": semester.text,
            "from": location.text,
            "desc": about.text,
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (imageFile.path != null) {
          var url = Uri.parse("http://10.0.2.2:8800/api/upload");
          var imageResponse = await http.post(url,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                "profilePicture": imageFile.path,
              }));
          if (imageResponse.statusCode == 200) {
            circular = false;
            update();
            Get.offAll(() => FeedScreen());
          }
        } else {
          circular = false;
          update();
          Get.offAll(() => FeedScreen());
        }
      }
    }
  }
}
