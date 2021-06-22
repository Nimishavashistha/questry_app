import 'package:get/get.dart';
import 'package:questry/app/modules/authentication/views/sign_-in_page.dart';
import 'package:questry/app/modules/authentication/views/sign_up_page.dart';
import '../modules/authentication/bindings/auth_binding.dart';
part 'app_routes.dart';

abstract class AppPages {
  static var transitionDuration = const Duration(milliseconds: 300);
  static final pages = <GetPage>[
    GetPage(
        name: _Paths.signin,
        page: () => SignInPage(),
        transitionDuration: transitionDuration,
        binding: AuthBinding()),
    GetPage(
        name: _Paths.signup,
        page: () => GMSignUpPage(),
        transitionDuration: transitionDuration,
        binding: AuthBinding()),
  ];
}
