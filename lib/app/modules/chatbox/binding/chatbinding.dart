import 'package:get/get.dart';
import 'package:questry/app/modules/chatbox/controller/chatController.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
