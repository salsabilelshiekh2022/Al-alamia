import 'package:alalamia/core/components/widgets/empty_widget.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/enums/transactions_enum.dart';
import '../../cubit/transactions_cubit.dart';
import '../../cubit/transactions_state.dart';

import '../../../data/models/transaction_model.dart';
import 'transaction_card.dart';

class TransactionsListWidget extends StatefulWidget {
  const TransactionsListWidget({super.key});

  @override
  State<TransactionsListWidget> createState() => _TransactionsListWidgetState();
}

class _TransactionsListWidgetState extends State<TransactionsListWidget> {
  late ScrollController _scrollController;
  
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    // Initial fetch
    context.read<TransactionsCubit>().fetchTransactionList(transaction: TransactionsEnum.recieving);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<TransactionsCubit>().loadMoreTransactions();
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
    return BlocConsumer<TransactionsCubit, TransactionsState>(
      listener: (context, state) {

      },
      builder: (context, state) {

        
        bool isInitialLoading = state.isLoading && state.transactionsList.isEmpty;
        bool isEmpty = !isInitialLoading && state.transactionsList.isEmpty;

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

        return RefreshIndicator(
          onRefresh: () => context.read<TransactionsCubit>().refreshTransactions(),
          child: ListView.separated(
            controller: _scrollController,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: isInitialLoading ? 5 : state.transactionsList.length + (state.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (isInitialLoading) {
                 return Skeletonizer(
                   enabled: true,
                   child: TransactionCard(transactionModel: dummyTransactionModel),
                 );
              }
              
              if (index < state.transactionsList.length) {
                return TransactionCard(
                  transactionModel: state.transactionsList[index],
                );
              }
              
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            },
            separatorBuilder: (context, index) => 16.verticalSizedBox,
          ),
        );
      },
    );
  }
  
}
