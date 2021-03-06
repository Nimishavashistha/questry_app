import 'package:get/get.dart';
import 'package:questry/app/data/addpostModel.dart';
import 'app_pages.dart';

abstract class RoutesManagement {
  static void goToSignUpScreen() {
    Get.toNamed<void>(AppRoutes.signup);
  }

  static void goToSignInScreen() {
    Get.off<void>(AppRoutes.signin);
  }

  static void goToForgotPasswordScreen() {
    Get.toNamed<void>(AppRoutes.forgotpassword);
  }

  static void goToProfilePage() {
    Get.toNamed<void>(AppRoutes.ProfilePage);
  }

  static void goToEditProfilePage() {
    Get.toNamed<void>(AppRoutes.EditProfile);
  }

  static void goToSettingsPage() {
    Get.toNamed<void>(AppRoutes.settings);
  }

  static void goToAddPostsPage() {
    Get.toNamed<void>(AppRoutes.addPost);
  }

  static void goToMyPostsPage() {
    Get.toNamed<void>(AppRoutes.myPosts);
  }

  static void goToChatPage() {
    Get.toNamed<void>(AppRoutes.chatScreen);
  }

  static void goToQuestAnsPage(AddPostModel item, List comments) {
    Get.toNamed<void>(AppRoutes.questionAnswerPage,
        arguments: [item, comments]);
  }
}
