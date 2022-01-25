import 'package:flutter/material.dart';
import 'package:questry/app/data/profileModel.dart';

import 'package:questry/app/modules/chatbox/views/chatscreen.dart';

class CustomCard extends StatelessWidget {
  final ProfileModel profile;

  const CustomCard({Key key, this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      profile: profile,
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
    );
  }
}
