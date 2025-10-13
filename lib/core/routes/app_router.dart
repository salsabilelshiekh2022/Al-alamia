import 'package:alalamia/features/splash/presentations/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'routes.dart';

abstract class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashView:
        return MaterialPageRoute(builder: (_) => const SplashView());

      default:
        return MaterialPageRoute(builder: (_) => const SplashView());
    }
  }
}
