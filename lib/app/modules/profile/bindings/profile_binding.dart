import 'package:get/get.dart';
import 'package:questry/app/modules/chatbox/controller/chatController.dart';
import '../../profile/controller/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
