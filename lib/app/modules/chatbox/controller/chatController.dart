import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:questry/app/data/conversationModel.dart';
import 'package:questry/app/data/profileModel.dart';

class ChatController extends GetxController {
  FlutterSecureStorage storage = FlutterSecureStorage();
  String baseurl = "http://10.0.2.2:8800";
  ConversationModel conversationModel = ConversationModel();
  ProfileModel user = ProfileModel();
  bool circular = false;
  List<ProfileModel> allFriendsId = [];

  void getConversations() async {
    circular = true;
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/conversations");
    var response = await http.get(
      url,
      headers: <String, String>{"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body)["data"];
      data.asMap().forEach((index, value) async {
        String userId = value["members"][1];
        print(userId);
        await gettingUser(userId);
        print("inside get conv fun: ${user.desc}");
        allFriendsId.add(user);
        update();
      });
      print(allFriendsId);
      circular = false;
      update();
    }
  }

  void gettingUser(String userId) async {
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/users/${userId}");
    var res = await http.get(
      url,
      headers: <String, String>{"Authorization": "Bearer $token"},
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      user = ProfileModel.fromJson(jsonDecode(res.body)["data"]);
      // print("inside getting user fun: ${user.username}");
      update();
    }
  }
}
