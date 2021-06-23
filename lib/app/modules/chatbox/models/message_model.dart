import 'package:questry/app/modules/chatbox/models/user.dart';

class Message {
  final User sender;
  final String time;
  final String text;
  final bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.unread,
  });
}

List<Message> chats = [
  Message(
    sender: SimranBhogal,
    time: '12:20pm',
    text: 'Hey! Can you help me with this question?',
    unread: true,
  ),
  Message(
    sender: MuskanRoy,
    time: '13:20pm',
    text: 'Hey! Can you help me with this question?',
    unread: true,
  ),
  Message(
    sender: NishaRoy,
    time: '14:20pm',
    text: 'Hey! Can you help me with this question?',
    unread: false,
  ),
  Message(
    sender: AnupKumar,
    time: '15:20pm',
    text: 'Hey! Can you help me with this question?',
    unread: false,
  ),
  Message(
    sender: KabirPiplani,
    time: '15:50pm',
    text: 'Hey! Can you help me with this question?',
    unread: false,
  ),
];

List<Message> messages = [
  Message(
    sender: SimranBhogal,
    time: '12:20pm',
    text: 'Hey! Can you help me with this question?',
    unread: true,
  ),
  Message(
    sender: MuskanRoy,
    time: '13:20pm',
    text: 'Hey! Can you help me with this question?',
    unread: true,
  ),
  Message(
    sender: NishaRoy,
    time: '14:20pm',
    text: 'Hey! Can you help me with this question?',
    unread: false,
  ),
  Message(
    sender: AnupKumar,
    time: '15:20pm',
    text: 'Hey! Can you help me with this question?',
    unread: false,
  ),
  Message(
    sender: KabirPiplani,
    time: '15:50pm',
    text: 'Hey! Can you help me with this question?',
    unread: false,
  ),
];
