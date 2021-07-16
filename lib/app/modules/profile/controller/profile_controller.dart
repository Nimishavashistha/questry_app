import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:questry/app/data/addpostModel.dart';
import 'package:questry/app/data/profileModel.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:questry/app/data/superModel.dart';
import 'package:questry/app/modules/home/homepage.dart';

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
  int currentIndex = 0;
  SuperModel superModel;
  List<AddPostModel> data = [];
  String baseurl = "http://10.0.2.2:8800";

  void setCurrentIndexToZero() {
    currentIndex = 0;
    update();
  }

  void setCurrentIndexToOne() {
    currentIndex = 1;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchPostsData();
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
    imageFile = pickedFile;
    update();
  }

  void submit() async {
    print("inside submit function");
    circular = true;
    update();
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/users/update");
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
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (imageFile.path != null) {
        print("inside image");
        var url = "http://10.0.2.2:8800/api/upload";
        var imageResponse = patchImage(url, imageFile.path);
        fetchData();
        // print(imageResponse);

        // if (imageResponse.statusCode == 200) {
        //   circular = false;
        //   update();
        //   Get.offAll(() => FeedScreen());
        // }
      } else {
        circular = false;
        update();
        Get.offAll(() => HomePage());
      }
    }
  }

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

  void fetchPostsData() async {
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/posts/getOwnPost/");
    var response = await http.get(
      url,
      headers: <String, String>{"Authorization": "Bearer $token"},
    );
    // print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
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
}
