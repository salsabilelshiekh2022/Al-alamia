import 'package:alalamia/features/auth/presentation/views/sign_up_view.dart';
import 'package:alalamia/features/splash/presentations/views/splash_view.dart';
import 'package:flutter/material.dart';
import '../../features/auth/presentation/views/login_view.dart';
import 'routes.dart';

abstract class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashView:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginView:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.signUpView:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      default:
        return MaterialPageRoute(builder: (_) => const SplashView());
    }
  }
}
