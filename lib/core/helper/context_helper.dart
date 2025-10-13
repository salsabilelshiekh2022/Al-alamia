import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NavigationServices {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }

  static BuildContext? fetchCurrentContext() {
    return navigatorKey.currentContext;
  }

  static String fetchCurrentLanguage() {
    return navigatorKey.currentContext?.locale.languageCode ?? 'ar';
  }
}
