import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/features/expenses/presentation/cubit/expenses_state.dart';
import 'package:alalamia/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../core/database/cache/cache_helper.dart';
import '../../../../core/database/cache/cache_services.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helper/app_extention.dart';
import '../../../../core/helper/translation_extensions.dart';
import '../../../../core/helper/widget_extentions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../generated/app_assets.dart';
import '../../../home/data/models/currency_model.dart';
import '../cubit/expenses_cubit.dart';
import 'widgets/expenses_list_widget.dart';

class ExpensesListView extends StatefulWidget {
  const ExpensesListView({super.key});

  @override
  State<ExpensesListView> createState() => _ExpensesListViewState();
}

class _ExpensesListViewState extends State<ExpensesListView> {
  CurrencyModel? selectedCurrency;

  @override
  void initState() {
    final user = getIt<CacheServices>().getDataFromCache(
      boxName: CacheBoxes.userModelBox,
      key: 'user',
    );
    selectedCurrency = context
        .read<HomeCubit>()
        .state
        .currenciesList
        .where((currency) => currency.name == user?.currency)
        .firstOrNull;

    // context.read<ExpensesCubit>().getExpenses(); // Handled by list widget
    context.read<ExpensesCubit>().getExpensesByCurrency(
      id: selectedCurrency!.id!,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        context.read<ExpensesCubit>().refreshExpenses();
        context.read<ExpensesCubit>().getExpensesByCurrency(
          id: selectedCurrency!.id!,
        );

        return Future.value();
      },
      child: Scaffold(
        floatingActionButton: InkWell(
          onTap: () => context.pushNamed(Routes.addExpensesView, arguments: {
            'expensesCubit': context.read<ExpensesCubit>(),
          }),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.primaryColor,
            ),
            child: Icon(Icons.add_rounded, color: context.colors.whiteColor),
          ),
        ),
        body: Stack(
          children: [
            _buildBackgroundImage(),
            Column(
              children: [
                CustomAppBar(
                  title: context.expenses,
                  isBack: true,
                ).onlyPadding(bottomPadding: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<ExpensesCubit, ExpensesState>(
                      builder: (context, state) {
                        return Text(
                          "${state.expensesAmountByCurrency ?? "0.0"}",
                          style: context.textStyles.font24BoldSecondaryColor
                              .copyWith(color: context.colors.whiteColor),
                        );
                      },
                    ),
                    6.horizontalSizedBox,
                    Text(
                      selectedCurrency?.name ?? "",
                      style: context.textStyles.font16RegularSecondaryColor
                          .copyWith(color: context.colors.whiteColor),
                    ).verticalPadding(8),
                  ],
                ),
                8.verticalSizedBox,
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.all(24),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.colors.backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.expense,
                          style: context.textStyles.font15SemiBoldSecondaryColor
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        18.verticalSizedBox,
                        const Expanded(child: ExpensesListWidget()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Image _buildBackgroundImage() {
    return Image.asset(
      AppAssets.imagesBackground,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
