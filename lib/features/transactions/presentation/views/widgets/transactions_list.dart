import 'package:alalamia/core/components/widgets/empty_widget.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/features/transactions/presentation/cubit/transactions_cubit.dart';
import 'package:alalamia/features/transactions/presentation/cubit/transactions_state.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/enums/request_status.dart';
import '../../../data/models/transaction_model.dart';
import 'transaction_card.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (context, state) {
        bool isLoading = state.transactionsStatus == RequestStatus.loading;
        bool isEmpty =
            state.transactionsStatus == RequestStatus.success && state.transactions!.isEmpty;
                return Skeletonizer(
          enabled: isLoading,
          child:isEmpty ?Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              65.verticalSizedBox,
              EmptyWidget(imagePath: AppAssets.imagesEmptyTransaction, title: context.notFoundTransactions, description: context.notFoundTransactionsDescription).center(),
            ],
          ) : ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: isLoading ? 5 : state.transactions?.length ?? 0,
            itemBuilder: (context, index) => TransactionCard(
              transactionModel:isLoading ? dummyTransactionModel :  state.transactions![index],
            ),
            separatorBuilder: (context, index) => 16.verticalSizedBox,
          ),
        );
      },
    );
  }
}
