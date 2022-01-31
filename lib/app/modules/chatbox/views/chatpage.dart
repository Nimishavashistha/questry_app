import 'package:flutter/material.dart';
import 'package:questry/app/modules/chatbox/controller/chatController.dart';
import 'package:questry/app/modules/chatbox/views/customecard.dart';
import 'package:get/get.dart';
import 'package:questry/app/data/profileModel.dart';
import 'package:questry/app/modules/profile/controller/profile_controller.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());

    return GetBuilder<ChatController>(
        builder: (controller) => Scaffold(
            body: controller.allFriendsId.length == 0
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: controller.allFriendsId.length,
                    itemBuilder: (BuildContext context, index) {
                      return GetBuilder<ProfileController>(
                          builder: (profilecontroller) => CustomCard(
                                profile: controller.allFriendsId[index],
                                conversationId:
                                    controller.AllconversationId[index],
                                userId: profilecontroller.profileModel.id,
                              ));
                    })));
  }
}
