import 'package:flutter/material.dart';
import 'package:questry/app/modules/chatbox/controller/chatController.dart';
import 'package:questry/app/modules/chatbox/views/customecard.dart';
import 'package:get/get.dart';
import 'package:questry/app/data/profileModel.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
        builder: (controller) => Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0xFF25D366),
              onPressed: () {
                controller.getConversations();
              },
              child: Icon(Icons.chat),
            ),
            body: controller.allFriendsId.length == 0
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: controller.allFriendsId.length,
                    itemBuilder: (BuildContext context, index) {
                      return CustomCard(
                        profile: controller.allFriendsId[index],
                      );
                    })));
  }
}
