import 'package:alalamia/core/enums/debets_enum.dart';
import 'package:alalamia/core/general/cubit/general_cubit.dart';
import 'package:alalamia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:alalamia/features/auth/presentation/views/registuration_method_view.dart';
import 'package:alalamia/features/auth/presentation/views/sign_up_view.dart';
import 'package:alalamia/features/debts/presentation/cubit/debts_cubit.dart';
import 'package:alalamia/features/debts/presentation/views/payment_debt_view.dart';
import 'package:alalamia/features/debts/presentation/views/request_debt_view.dart';
import 'package:alalamia/features/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:alalamia/features/expenses/presentation/views/expenses_list_view.dart';
import 'package:alalamia/features/expenses/presentation/views/add_expenses_view.dart';
import 'package:alalamia/features/in_and_out_transaction/presentation/views/in_and_out_transaction_view.dart';
import 'package:alalamia/features/main_navigation/presentation/views/main_naviagtion.dart';
import 'package:alalamia/features/send_money/presentation/cubit/send_money_cubit.dart';
import 'package:alalamia/features/send_money/presentation/views/send_money_second_step_view.dart';
import 'package:alalamia/features/settings/presentation/views/settings_view.dart';
import 'package:alalamia/features/splash/presentations/views/splash_view.dart';
import 'package:alalamia/features/support/presentation/views/support_view.dart';
import 'package:alalamia/features/transactions/presentation/views/transactions_details_view.dart.dart';
import 'package:alalamia/features/transfer_money/presentation/views/add_amount_by_denomination_view.dart';
import 'package:alalamia/features/transfer_money/presentation/views/transfer_money_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/debts/presentation/views/debts_view.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/in_and_out_transaction/presentation/cubit/in_and_out_transaction_cubit.dart';
import '../../features/send_money/presentation/views/send_money_frist_step_view.dart';
import '../../features/settings/presentation/views/change_password_view.dart';
import '../../features/settings/presentation/views/profile_setting_view.dart';
import '../../features/transactions/presentation/views/transactions_view.dart';
import '../../features/transfer_money/presentation/views/transaction_recipt_view.dart';
import '../../features/transfer_money/data/models/transfer_money_data_params.dart';
import '../../features/transfer_money/presentation/cubit/transfer_money_cubit.dart';
import '../di/dependency_injection.dart';
import 'routes.dart';

abstract class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashView:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(authRepo: getIt<AuthRepo>()),
            child: const LoginView(),
          ),
        );
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
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<HomeCubit>(),
            child: BlocProvider.value(
              value: getIt<GeneralCubit>(),
              child: const TransferMoneyView(),
            ),
          ),
        );
      case Routes.transactionReciptView:
        return MaterialPageRoute(builder: (_) => const TransactionReciptView());
      case Routes.sendMoneyFristStepView:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<HomeCubit>()),
              BlocProvider.value(value: getIt<GeneralCubit>()),
              BlocProvider.value(value: getIt<SendMoneyCubit>()),
            ],
            child: const SendMoneyFristStepView(),
          ),
        );
      case Routes.sendMoneySecondStepView:
        // Use the cubit passed from step 1 to preserve form data
        final cubit = settings.arguments as SendMoneyCubit;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<GeneralCubit>()),
              BlocProvider.value(value: getIt<HomeCubit>()),
              BlocProvider.value(value: cubit), // Use passed cubit instance
            ],
            child: SendMoneySecondStepView(),
          ),
        );
      case Routes.registerationMethodView:
        return MaterialPageRoute(
          builder: (_) => const RegisturationMethodView(),
        );
      case Routes.requestDeptView:
        final debetsType = settings.arguments as DebetsTypeEnum;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<HomeCubit>(),
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => getIt<DebtsCubit>()),
                BlocProvider.value(value: getIt<HomeCubit>()),
                BlocProvider.value(value: getIt<GeneralCubit>()),
              ],
              child: RequestDebtView(debetType: debetsType),
            ),
          ),
        );
      case Routes.paymentDeptView:
        final debtType = settings.arguments as DebetsTypeEnum;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<HomeCubit>()),
              BlocProvider.value(value: getIt<GeneralCubit>()),
              BlocProvider(create: (context) => getIt<DebtsCubit>()),
            ],
            child: PaymentDebtView(debtType: debtType),
          ),
        );
      case Routes.addExpensesView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<HomeCubit>(),
            child: BlocProvider(
              create: (context) => getIt<ExpensesCubit>(),
              child: const AddExpensesView(),
            ),
          ),
        );
      case Routes.supportView:
        return MaterialPageRoute(builder: (_) => const SupportView());
      case Routes.expensesListView:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<HomeCubit>()),
              BlocProvider.value(value: getIt<ExpensesCubit>()),
            ],

            child: const ExpensesListView(),
          ),
        );
      case Routes.addAmountByDenominationView:
        final transferData = settings.arguments as TransferMoneyDataParams;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<GeneralCubit>()),
              BlocProvider(create: (_) => getIt<TransferCurrencyCubit>()),
            ],
            child: AddAmountByDenominationView(transferData: transferData),
          ),
        );
      case Routes.debtsView:
        final debtType = settings.arguments as DebetsTypeEnum;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<HomeCubit>()),
              BlocProvider.value(value: getIt<DebtsCubit>()),
            ],
            child: DebtsView(debetType: debtType),
          ),
        );
      case Routes.inAndOutTransactionView:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<HomeCubit>()),
              BlocProvider.value(value: getIt<GeneralCubit>()..getAllBranches()),
              BlocProvider.value(value: getIt<InAndOutTransactionCubit>()),
            ],
            child: const InAndOutTransactionView(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const SplashView());
    }
  }
}
