import 'package:get/get.dart';
import 'package:questry/app/modules/authentication/views/forgot-password.dart';
import 'package:questry/app/modules/authentication/views/sign_-in_page.dart';
import 'package:questry/app/modules/authentication/views/sign_up_page.dart';
import 'package:questry/app/modules/chatbox/binding/chatbinding.dart';
import 'package:questry/app/modules/chatbox/views/chatpage.dart';
import 'package:questry/app/modules/feed/binding/feed_binding.dart';
import 'package:questry/app/modules/feed/views/feedScreen.dart';
import 'package:questry/app/modules/feed/views/pages/add_posts.dart';
import 'package:questry/app/modules/feed/views/pages/questionWithAnswerPage.dart';
import 'package:questry/app/modules/home/bindings/home_binding.dart';
import 'package:questry/app/modules/home/homepage.dart';
import 'package:questry/app/modules/profile/bindings/profile_binding.dart';
import 'package:questry/app/modules/profile/views/pages/edit_profile.dart';
import 'package:questry/app/modules/profile/views/pages/posts.dart';
import 'package:questry/app/modules/profile/views/profile_page.dart';
import '../modules/authentication/bindings/auth_binding.dart';
import 'package:questry/app/modules/profile/views/pages/settings.dart';
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
    GetPage(
        name: _Paths.forgotpassword,
        page: () => ForgotPasswordPage(),
        transitionDuration: transitionDuration,
        binding: AuthBinding()),
    GetPage(
        name: _Paths.FeedScreen,
        page: () => FeedScreen(),
        transitionDuration: transitionDuration,
        binding: FeedBinding()),
    GetPage(
      name: _Paths.homePage,
      page: () => HomePage(),
      binding: HomeBinding(),
      transitionDuration: transitionDuration,
    ),
    GetPage(
        name: _Paths.ProfilePage,
        page: () => ProfilePage(false),
        transitionDuration: transitionDuration,
        binding: ProfileBinding()),
    GetPage(
      name: _Paths.EditProfile,
      page: () => EditProfilePage(),
      binding: ProfileBinding(),
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: _Paths.myPosts,
      page: () => PostScreen(),
      binding: ProfileBinding(),
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: _Paths.questionAnswerPage,
      page: () => QuestionWithAnswerPage(),
      binding: HomeBinding(),
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: _Paths.settings,
      page: () => SettingsPage(),
      transitionDuration: transitionDuration,
    ),
    // GetPage(
    //     name: _Paths.LoadingPage,
    //     page: () => LoadingPage(),
    //     transitionDuration: transitionDuration,
    //     binding: AuthBinding()),
    GetPage(
      name: _Paths.addPost,
      page: () => AddPost(),
      binding: FeedBinding(),
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: _Paths.chatScreen,
      page: () => ChatPage(),
      binding: ChatBinding(),
      transitionDuration: transitionDuration,
    )
  ];
}
