import 'package:flutter/material.dart';

@immutable
class Routes {
  const Routes._();
  static const String initialRoute = appRootScreenRoute;
  static const String appRootScreenRoute = 'app-root-screen';
  static const String onboardingScreenRoute = '/onboarding-screen';
  static const String loginScreenRoute = 'login-screen';
  static const String registerScreenRoute = 'register-screen';
  static const String homeScreenRoute = '/home-screen';
}
