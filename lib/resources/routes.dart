import 'package:flutter/material.dart';
import 'package:sitter_swipe/pages/base_screen.dart';
import 'package:sitter_swipe/pages/forgot_password/forgot_password.dart';
import 'package:sitter_swipe/pages/login/login.dart';
import 'package:sitter_swipe/pages/notifications/notifications.dart';
import 'package:sitter_swipe/pages/onboarding/onboarding.dart';
import 'package:sitter_swipe/pages/register/register.dart';
import 'package:sitter_swipe/pages/settings/settings.dart';
import 'package:sitter_swipe/pages/wrapper.dart';
import 'package:sitter_swipe/resources/strings.dart';

class Routes {
  static const baseScreen = '/baseScreen'; // baseScreen with bottom nav
  static const login = '/login';
  static const register = '/register';
  static const onboarding = '/onboarding';
  static const forgotPassword = '/forgot_password';
  static const notifications = "/notifications";
  static const settings = '/settings';
  static const wrapper = '/wrapper';
  // swipe, chats, and interested don't need to be here
  // they will be inside baseScreen

  static const homeIndex = 0;
  static const interestedIndex = 1;
  static const messagesIndex = 2;
  static const profileIndex = 3;
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.baseScreen:
        return MaterialPageRoute(builder: (_) => BaseScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case Routes.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsPage());
      case Routes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case Routes.wrapper:
        return MaterialPageRoute(builder: (_) => Wrapper());
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
