part of 'app_pages.dart';

abstract class AppRoutes {
  static const signin = _Paths.signin;
  static const signup = _Paths.signup;
  static const ProfilePage = _Paths.ProfilePage;
  static const FeedScreen = _Paths.FeedScreen;
  static const EditProfile = _Paths.EditProfile;
  static const settings = _Paths.settings;
}

abstract class _Paths {
  static const signin = '/signin';
  static const signup = '/signup';
  static const ProfilePage = '/profilepage';
  static const FeedScreen = '/feedScreen';
  static const EditProfile = '/editprofile';
  static const settings = '/settings';
}