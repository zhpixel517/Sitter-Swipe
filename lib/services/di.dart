import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sitter_swipe/pages/broadcast/broadcast_viewmodel.dart';
import 'package:sitter_swipe/pages/chat/chat_viewmodel.dart';
import 'package:sitter_swipe/pages/forgot_password/forgot_viewmodel.dart';
import 'package:sitter_swipe/pages/interested/interested_viewmodel.dart';
import 'package:sitter_swipe/pages/login/login_viewmodel.dart';
import 'package:sitter_swipe/pages/notifications/notifications_viewmodel.dart';
import 'package:sitter_swipe/pages/onboarding/onboarding_viewmodel.dart';
import 'package:sitter_swipe/pages/profile/profile_viewmodel.dart';
import 'package:sitter_swipe/pages/register/register_viewmodel.dart';
import 'package:sitter_swipe/pages/settings/settings_viewmodel.dart';
import 'package:sitter_swipe/pages/swipe/swipe_viewmodel.dart';
import 'package:sitter_swipe/services/firebase/auth.dart';
import 'package:sitter_swipe/services/network_info.dart';
import 'package:sitter_swipe/services/notifications/notification_service.dart';
import 'package:sitter_swipe/services/preferences/app_preferences.dart';
import 'package:sitter_swipe/services/responsive.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  instance.allowReassignment = true;
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

  // shared preferences instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  //view models

  instance.registerLazySingleton<ChatViewModel>(() => ChatViewModel());

  instance.registerLazySingleton<ForgotPasswordViewModel>(
      () => ForgotPasswordViewModel());

  instance.registerLazySingleton<InterestedPageViewModel>(
      () => InterestedPageViewModel());

  instance.registerLazySingleton<LoginViewModel>(() => LoginViewModel());

  instance
      .registerLazySingleton<OnboardingViewModel>(() => OnboardingViewModel());

  instance.registerLazySingleton<UserProfileViewModel>(
      () => UserProfileViewModel());

  instance.registerLazySingleton<RegisterViewModel>(() => RegisterViewModel());

  instance.registerLazySingleton<SettingsViewModel>(() => SettingsViewModel());

  instance.registerLazySingleton<SwipeViewModel>(() => SwipeViewModel());

  instance.registerLazySingleton<NotificationPageViewModel>(
      () => NotificationPageViewModel());

  instance
      .registerLazySingleton<BroadcastViewModel>(() => BroadcastViewModel());

  // helper classes
  instance.registerLazySingleton<Responsive>(() => const Responsive());

  instance.registerLazySingleton<AuthService>(() => AuthService());

  // instance.registerLazySingleton<SitterDatabase>(() => SitterDatabase());

  instance.registerLazySingleton<AppPreferences>(() => AppPreferences());

  instance
      .registerLazySingleton<NotificationService>(() => NotificationService());
}
