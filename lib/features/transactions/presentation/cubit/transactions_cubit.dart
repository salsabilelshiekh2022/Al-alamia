
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/request_status.dart';
import '../../../../core/enums/transactions_enum.dart';
import '../../data/repos/transactions_repo.dart';
import 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState>{

  TransactionsCubit({required this.transactionRepo}) : super(const TransactionsState());
  final TransactionsRepo transactionRepo;

  Future<void> getTransactionList({required TransactionsEnum transaction}) async {
    emit(state.copyWith(transactionsStatus: RequestStatus.loading));
    final result = await transactionRepo.getTransactionList(transaction: transaction);
    result.fold(
      (failure) => emit(
        state.copyWith(
          transactionsStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (transactions) => emit(
        state.copyWith(
          transactionsStatus: RequestStatus.success,
          transactions: transactions,
        ),
      ),
    );
  }
}