import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/features/expenses/presentation/cubit/expenses_state.dart';
import 'package:alalamia/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../core/components/widgets/empty_widget.dart';
import '../../../../core/enums/request_status.dart';
import '../../../../core/helper/app_extention.dart';
import '../../../../core/helper/translation_extensions.dart';
import '../../../../core/helper/widget_extentions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../generated/app_assets.dart';
import '../../../home/data/models/currency_model.dart';
import '../../data/models/expense_model.dart';
import '../cubit/expenses_cubit.dart';
import 'widgets/expense_item.dart';

class ExpensesListView extends StatefulWidget {
  const ExpensesListView({super.key});

  @override
  State<ExpensesListView> createState() => _ExpensesListViewState();
}

class _ExpensesListViewState extends State<ExpensesListView> {
  CurrencyModel? selectedCurrency;

  @override
  void initState() {
    selectedCurrency = context.read<HomeCubit>().state.currenciesList.first;

    context.read<ExpensesCubit>().getExpenses();
    context.read<ExpensesCubit>().getExpensesByCurrency(
      id: selectedCurrency!.id!,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () => context.pushNamed(Routes.addExpensesView),
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
          SingleChildScrollView(
            child: Column(
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
                          "0",
                          style: context.textStyles.font24BoldSecondaryColor
                              .copyWith(color: context.colors.whiteColor),
                        );
                      },
                    ),
                    6.horizontalSizedBox,
                    Text(
                      "الدينار الليبي",
                      style: context.textStyles.font16RegularSecondaryColor
                          .copyWith(color: context.colors.whiteColor),
                    ).verticalPadding(8),
                  ],
                ),
                8.verticalSizedBox,
                // SizedBox(
                //   width: 150.w,
                //   child: CustomCurrencyDropdown(
                //     items: context.read<HomeCubit>().state.currenciesList,
                //     selectedItem: selectedCurrency,
                //     onChanged: (val) {
                //       setState(() {
                //         selectedCurrency = val;
                //         context.read<ExpensesCubit>().getExpensesByCurrency(
                //           id: val!.id!,
                //         );
                //       });
                //     },
                //     color: Colors.white,
                //     displayImageCurrency: false,
                //   ),
                // ),
                // 12.verticalSizedBox,
                // MainButton(
                //   title: context.addExpenses,
                //   onTap: () => context.pushNamed(Routes.addExpensesView),
                //   color: Colors.white.withValues(alpha: 0.08),
                //   borderColor: context.colors.whiteColor.withValues(
                //     alpha: 0.36,
                //   ),
                //   icon: AppAssets.svgsCash,
                // ).horizontalPadding(16),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(24),
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 130.h,
                  ),

                  decoration: BoxDecoration(
                    color: context.colors.whiteColor,
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
                      BlocBuilder<ExpensesCubit, ExpensesState>(
                        builder: (context, state) {
                          bool isLoading =
                              state.expensesStatus.isLoading &&
                              state.expenses == null;
                          bool isEmpty =
                              !isLoading &&
                              (state.expenses == null ||
                                  state.expenses!.isEmpty);
                          return Skeletonizer(
                            enabled: isLoading,
                            child: isEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      65.verticalSizedBox,
                                      EmptyWidget(
                                        imagePath:
                                            AppAssets.imagesEmptyTransaction,
                                        title: context.notFoundTransactions,
                                        description: context
                                            .notFoundTransactionsDescription,
                                      ).center(),
                                    ],
                                  )
                                : ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                        16.verticalSizedBox,
                                    itemCount: isLoading
                                        ? 3
                                        : state.expenses?.length ?? 0,
                                    itemBuilder: (context, index) =>
                                        ExpenseItem(
                                          expenseModel: isLoading
                                              ? dummyExpenseModel
                                              : state.expenses![index]!,
                                        ),
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
