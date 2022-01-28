import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questry/app/data/profileModel.dart';
import 'package:questry/app/modules/chatbox/controller/chatController.dart';

import 'package:questry/app/modules/chatbox/views/chatscreen.dart';

class CustomCard extends StatelessWidget {
  final ProfileModel profile;
  final String conversationId;
  final String userId;

  const CustomCard({Key key, this.profile, this.conversationId, this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
        builder: (controller) => InkWell(
              onTap: () async {
                // print("conv id inside custom card ${conversationId}");
                await controller.getMessages(conversationId);
                // print(
                // "inside custom card all messages = ${controller.allMessages}");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatScreen(
                              chatcontroller: controller,
                              profile: profile,
                              conversationId: conversationId,
                              userId: userId,
                            )));
              },
              child: Column(
                children: [
                  ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueGrey[200],
                        radius: 30,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        profile.username,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text("3:00"),
                      subtitle: Row(
                        children: [
                          Icon(Icons.done_all),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            "hey",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 80),
                    child: Divider(
                      thickness: 1,
                    ),
                  )
                ],
              ),
            ));
  }
}
