import 'package:flutter/material.dart';
import 'package:questry/app/modules/chatbox/models/chatmodel.dart';
import 'package:questry/app/modules/chatbox/views/chatscreen.dart';

class CustomCard extends StatelessWidget {
  final ChatModel chatmodel;

  const CustomCard({Key key, this.chatmodel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      chatmodel: chatmodel,
                    )));
      },
      child: Column(
        children: [
          ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueGrey[200],
                radius: 30,
                child: Icon(
                  chatmodel.isGroup ? Icons.group : Icons.person,
                  color: Colors.white,
                ),
              ),
              title: Text(
                chatmodel.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(chatmodel.time),
              subtitle: Row(
                children: [
                  Icon(Icons.done_all),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    chatmodel.currentMessage,
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
    );
  }
}
