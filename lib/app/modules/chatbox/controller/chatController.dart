import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:questry/app/data/conversationModel.dart';
import 'package:questry/app/data/profileModel.dart';

class ChatController extends GetxController {
  FlutterSecureStorage storage = FlutterSecureStorage();
  String baseurl = "http://10.0.2.2:8800";
  ConversationModel conversationModel = ConversationModel();
  bool circular = false;
  List<ProfileModel> allFriendsId = [];
  List<String> AllconversationId = [];
  var allMessages;
  var arrivalMessage;
  var conversationsData;
  bool getConv = false;

  void getConversations(String userId) async {
    circular = true;
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/conversations");
    var response = await http.get(
      url,
      headers: <String, String>{"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      conversationsData = jsonDecode(response.body)["data"];
      update();
      conversationsData.asMap().forEach((index, value) async {
        String conversationId = value["_id"];
        AllconversationId.add(conversationId);
        String receiverId;
        if (value["members"][1] != userId && value["members"][0] == userId) {
          receiverId = value["members"][1];
        } else if (value["members"][1] == userId &&
            value["members"][0] != userId) {
          receiverId = value["members"][0];
        }
        print("receiver id: ${receiverId}");
        ProfileModel user = ProfileModel();
        user = await gettingUser(receiverId);
        // print("user id: ${user.id}");
        allFriendsId.add(user);
        update();
        // print(conversationsData);
        // print(AllconversationId);
        // print(allFriendsId[0].id);
        // print(allFriendsId[1].id);
      });
      getConv = true;
      circular = false;
      update();
    }
  }

  void getMessages(String conversationId) async {
    circular = true;
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/messages/${conversationId}");
    var response = await http.get(
      url,
      headers: <String, String>{"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      allMessages = jsonDecode(response.body);
      // print("inside get messages fun");
      // print(allMessages);
      // data.asMap().forEach((index, value) async {
      //   print(value["_id"]);
      // });
      circular = false;
      update();
    }
  }

  Future<ProfileModel> gettingUser(String userId) async {
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/users/${userId}");
    var res = await http.get(
      url,
      headers: <String, String>{"Authorization": "Bearer $token"},
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      ProfileModel user = ProfileModel();
      user = ProfileModel.fromJson(jsonDecode(res.body)["data"]);
      // print("inside getting user fun: ${user.username}");
      return user;
    }
  }

  void addMessage(String conversationId, String message) async {
    String token = await storage.read(key: "token");
    var url = Uri.parse("http://10.0.2.2:8800/api/messages/");
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(<String, String>{
          "conversationId": conversationId,
          "text": message,
        }));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("inside add message function");
      print(response.body);
    }
  }
}
