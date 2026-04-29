import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/components/widgets/empty_widget.dart';
import '../../../../../core/helper/widget_extentions.dart';
import '../../../../../generated/app_assets.dart';
import '../../../data/models/expense_model.dart';
import '../../cubit/expenses_cubit.dart';
import '../../cubit/expenses_state.dart';
import 'expense_item.dart';

class ExpensesListWidget extends StatefulWidget {
  const ExpensesListWidget({super.key});

  @override
  State<ExpensesListWidget> createState() => _ExpensesListWidgetState();
}

class _ExpensesListWidgetState extends State<ExpensesListWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.read<ExpensesCubit>().fetchExpenses();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ExpensesCubit>().loadMoreExpenses();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesCubit, ExpensesState>(
      builder: (context, state) {
        bool isInitialLoading = state.isLoading && state.expensesList.isEmpty;
        bool isEmpty = !isInitialLoading && state.expensesList.isEmpty;

        if (state.isSuccess && isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              65.verticalSizedBox,
              EmptyWidget(
                imagePath: AppAssets.imagesEmptyTransaction,
                title: context.notFoundTransactions,
                description: context.notFoundTransactionsDescription,
              ).center(),
            ],
          );
        }

        return ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const AlwaysScrollableScrollPhysics(),
          separatorBuilder: (context, index) => 12.verticalSizedBox,
          itemBuilder: (_, index) {
            if (isInitialLoading) {
              return Skeletonizer(
                enabled: true,
                child: ExpenseItem(
                  expenseModel: dummyExpenseModel,
                ),
              );
            }
        
            if (index < state.expensesList.length) {
              return ExpenseItem(
                expenseModel: state.expensesList[index],
              );
            }
        
            // Show loading indicator when loading more
            if (state.isLoadingMore) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
        
            return const SizedBox.shrink();
          },
          itemCount: isInitialLoading
              ? 3
              : state.expensesList.length + (state.isLoadingMore || state.hasReachedMax ? 1 : 0),
        );
      },
    );
  }
}
