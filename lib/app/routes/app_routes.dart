part of 'app_pages.dart';

abstract class AppRoutes {
  static const signin = _Paths.signin;
  static const signup = _Paths.signup;
  static const ProfilePage = _Paths.ProfilePage;
  static const FeedScreen = _Paths.FeedScreen;
  static const EditProfile = _Paths.EditProfile;
  static const settings = _Paths.settings;
  static const loadingPage = _Paths.LoadingPage;
  static const addPost = _Paths.addPost;
  static const homePage = _Paths.homePage;
  static const myPosts = _Paths.myPosts;
}

abstract class _Paths {
  static const signin = '/signin';
  static const signup = '/signup';
  static const ProfilePage = '/profilepage';
  static const FeedScreen = '/feedScreen';
  static const EditProfile = '/editprofile';
  static const settings = '/settings';
  static const LoadingPage = '/Loadingpage';
  static const addPost = '/addPost';
  static const homePage = '/homePage';
  static const myPosts = '/myPosts';
}
