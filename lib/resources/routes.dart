import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/base_screen.dart';
import 'package:sitter_swipe/pages/forgot_password/forgot_password.dart';
import 'package:sitter_swipe/pages/login/login.dart';
import 'package:sitter_swipe/pages/onboarding/onboarding.dart';
import 'package:sitter_swipe/pages/profile/self/profile.dart';
import 'package:sitter_swipe/pages/register/register.dart';
import 'package:sitter_swipe/resources/strings.dart';

class Routes {
  static const baseScreen = '/baseScreen'; // baseScreen with bottom nav
  static const login = '/login';
  static const register = '/register';
  static const onboarding = '/onboarding';
  static const profile = '/profile';
  static const forgotPassword = '/forgot_password';

  // swipe, chats, and interested don't need to be here
  // they will be inside baseScreen
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.baseScreen:
        return MaterialPageRoute(builder: (_) => const BaseScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
