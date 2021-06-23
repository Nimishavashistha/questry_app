import 'package:get/get.dart';
import 'app_pages.dart';

abstract class RoutesManagement {
  static void goToSignUpScreen() {
    Get.toNamed<void>(AppRoutes.signup);
  }

  static void goToSignInScreen() {
    Get.toNamed<void>(AppRoutes.signin);
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
}
