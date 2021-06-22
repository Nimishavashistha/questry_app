import 'package:get/get.dart';
import 'app_pages.dart';

abstract class RoutesManagement {
  static void goToSignUpScreen() {
    Get.toNamed<void>(AppRoutes.signup);
  }

  static void goToSignInScreen() {
    Get.toNamed<void>(AppRoutes.signin);
  }
}
