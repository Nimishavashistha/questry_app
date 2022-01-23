import 'package:flutter/material.dart';
import 'package:questry/app/modules/chatbox/models/chatmodel.dart';
import 'package:questry/app/modules/chatbox/views/customecard.dart';

class ChatPage extends StatefulWidget {
  final List<ChatModel> chatmodels;
  final ChatModel sourceChat;

  const ChatPage({Key key, this.chatmodels, this.sourceChat}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF25D366),
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (builder) => selectContact()));
          },
          child: Icon(Icons.chat),
        ),
        body: ListView.builder(
            itemCount: widget.chatmodels.length,
            itemBuilder: (BuildContext context, index) {
              return CustomCard(
                chatmodel: widget.chatmodels[index],
                sourceChat: widget.sourceChat,
              );
            }));
  }
}
