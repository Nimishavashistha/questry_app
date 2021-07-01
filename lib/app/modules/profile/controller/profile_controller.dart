import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:questry/app/data/profileModel.dart';
import 'package:questry/app/modules/feed/views/feedScreen.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileController extends GetxController {
  final globalKey = GlobalKey<FormState>();
  TextEditingController semester = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController about = TextEditingController();
  PickedFile imageFile;
  final ImagePicker _picker = ImagePicker();
  bool circular = false;
  FlutterSecureStorage storage = FlutterSecureStorage();
  ProfileModel profileModel = ProfileModel();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    circular = true;
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/users/getData");
    var res = await http.get(
      url,
      headers: <String, String>{"Authorization": "Bearer $token"},
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      profileModel = ProfileModel.fromJson(jsonDecode(res.body)["data"]);
      update();
      circular = false;
    }
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    update();
  }

  void submit() async {
    print("inside submit function");
    circular = true;
    update();
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/users/update");
    print("semester=${semester.text}");
    print("from=${location.text}");
    print("about=${about.text}");
    final response = await http.patch(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(<String, String>{
          "sem": semester.text,
          "from": location.text,
          "desc": about.text,
        }));
    print("response ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (imageFile.path != null) {
        var url = "http://10.0.2.2:8800/api/upload";
        var imageResponse = patchImage(url, imageFile.path);
        print(imageResponse);

        // if (imageResponse.statusCode == 200) {
        //   circular = false;
        //   update();
        //   Get.offAll(() => FeedScreen());
        // }
      } else {
        circular = false;
        update();
        Get.offAll(() => FeedScreen());
      }
    }
  }

  Future<http.StreamedResponse> patchImage(String url, String filepath) async {
    String token = await storage.read(key: "token");
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("img", filepath));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer $token"
    });
    var response = request.send();
    return response;
  }

  Widget showProfile() {
    return Center(child: Text("Profile Data is Avalable"));
  }
}