import 'package:alalamia/features/auth/presentation/views/sign_up_view.dart';
import 'package:alalamia/features/main_navigation/presentation/views/main_naviagtion.dart';
import 'package:alalamia/features/settings/presentation/views/settings_view.dart';
import 'package:alalamia/features/splash/presentations/views/splash_view.dart';
import 'package:alalamia/features/transactions/presentation/views/transactions_details_view.dart.dart';
import 'package:alalamia/features/transfer_currency/presentation/views/transfer_currency_view.dart';
import 'package:flutter/material.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/settings/presentation/views/change_password_view.dart';
import '../../features/settings/presentation/views/profile_setting_view.dart';
import '../../features/transactions/presentation/views/transactions_view.dart';
import '../../features/transfer_currency/presentation/views/transaction_recipt_view.dart';
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
      case Routes.mainNavigationView:
        return MaterialPageRoute(builder: (_) => const MainNavigationView());
      case Routes.settingsView:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case Routes.changePasswordView:
        return MaterialPageRoute(builder: (_) => const ChangePasswordView());
      case Routes.profileSettingsView:
        return MaterialPageRoute(builder: (_) => const ProfileSettingView());
      case Routes.transactionsView:
        return MaterialPageRoute(builder: (_) => const TransactionsView());
      case Routes.transactionDetailsView:
        return MaterialPageRoute(
          builder: (_) => const TransactionsDetailsView(),
        );
      case Routes.transferCurrencyView:
        return MaterialPageRoute(builder: (_) => const TransferCurrencyView());
      case Routes.transactionReciptView:
        return MaterialPageRoute(builder: (_) => const TransactionReciptView());
      default:
        return MaterialPageRoute(builder: (_) => const SplashView());
    }
  }
}
