import 'package:flutter/cupertino.dart';

class ChatModel {
  String name;
  IconData icon;
  String status;
  bool isGroup;
  String time;
  String currentMessage;
  String imgUrl;
  bool select = false;
  ChatModel(
      {this.name,
      this.isGroup,
      this.time,
      this.currentMessage,
      this.imgUrl,
      this.icon,
      this.status});
}
