
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class AppRoutes {
  //api
  static const String splashScreen = '/';
  static const String onBoradingScreen = '/onBoradingScreen';
  static const String loginScreen = '/loginScreen';
  static const String registerScreen = '/registerScreen';
  static const String otpScrren = '/otpScrren';
  static const String homeScreen = '/homeScreen';
  static const String eventsScreen = '/eventsScreen';
  static const String eventsDeatilsScreen = '/eventsDeatilsScreen';
  static const String organizerScreen = '/organizerScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String bottomNavBarScreen = '/bottomNavBarScreen';
  //firebase
  static const String firbasebottomNavBarScreen = '/firbasebottomNavBarScreen';
  static const String firbaseRegisterScreen = '/firbaseRegisterScreen';
  static const String firbaseLoginScreen = '/firbaseLoginScreen';
  static const String firebaseEditProfileScreen = '/firebaseEditProfileScreen';
  static const String firebaseAllEventsScreen = '/firebaseAllEventsScreen';
  static const String firebaseEventDetailsScreen =
      '/firebaseEventDetailsScreen';
  static const String firebaseOrganizerScreen = '/firebaseOrganizerScreen';
}

class AppNavigator {
  AppNavigator._();

  static void go(BuildContext context, String path) {
    context.go(path);
  }

  static void goNamed(
    BuildContext context,
    String name, {
    Map<String, String>? params,
  }) {
    context.goNamed(name, pathParameters: params ?? {});
  }

  static Future<T?> push<T>(
    BuildContext context,
    String path, {
    Object? extra,
  }) {
    return context.push<T>(path, extra: extra);
  }

  static void pushNamed(
    BuildContext context,
    String name, {
    Map<String, String>? params,
  }) {
    context.pushNamed(name, pathParameters: params ?? {});
  }

  static void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    }
  }
}
