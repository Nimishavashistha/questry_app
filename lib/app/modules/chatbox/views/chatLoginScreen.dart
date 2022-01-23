import 'package:flutter/material.dart';
import 'package:questry/app/modules/chatbox/models/chatmodel.dart';
import 'package:questry/app/modules/chatbox/views/chatpage.dart';

import 'buttonCard.dart';

class chatLoginScreen extends StatefulWidget {
  @override
  _chatLoginScreenState createState() => _chatLoginScreenState();
}

class _chatLoginScreenState extends State<chatLoginScreen> {
  ChatModel sourceChat;
  List<ChatModel> chatmodel = [
    ChatModel(
        name: "Dev Stack",
        id: 1,
        isGroup: false,
        time: "4:00",
        currentMessage: "Hii",
        imgUrl: "assets/images/person1.jpg",
        icon: Icons.person),
    ChatModel(
        name: "Yulia",
        id: 2,
        isGroup: false,
        time: "7:00",
        currentMessage: "hlo Dev",
        icon: Icons.person),
    ChatModel(
        name: "rishi",
        id: 3,
        isGroup: false,
        time: "2:20",
        currentMessage: "hlo",
        imgUrl: "assets/images/person3.jpg",
        icon: Icons.person),
    ChatModel(
        name: "Henry",
        id: 4,
        isGroup: false,
        time: "1:05",
        currentMessage: "Hi whats'up",
        imgUrl: "assets/images/person1.jpg",
        icon: Icons.person),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatmodel.length,
        itemBuilder: (context, index) => InkWell(
          child: ButtonCard(
            name: chatmodel[index].name,
            icon: chatmodel[index].icon,
          ),
          onTap: () {
            sourceChat = chatmodel.removeAt(index);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (builder) => ChatPage(
                          chatmodels: chatmodel,
                          sourceChat: sourceChat,
                        )));
          },
        ),
      ),
    );
  }
}
