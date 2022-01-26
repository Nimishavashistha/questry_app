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
  List<String> AllconversationId = [];
  var allMessages;

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
        String conversationId = value["_id"];
        AllconversationId.add(conversationId);
        String userId = value["members"][1];
        await gettingUser(userId);
        allFriendsId.add(user);
        update();
      });
      // print(AllconversationId);
      circular = false;
      update();
    }
  }

  void getMessages(String conversationId) async {
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/messages/${conversationId}");
    var response = await http.get(
      url,
      headers: <String, String>{"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      allMessages = jsonDecode(response.body);
      // print(allMessages);
      // data.asMap().forEach((index, value) async {
      //   print(value["_id"]);
      // });
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
