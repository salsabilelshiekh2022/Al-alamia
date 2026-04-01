
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums/request_status.dart';
import '../../../../core/enums/transactions_enum.dart';
import '../../data/models/transaction_model.dart';
import '../../data/models/update_transaction_request_params.dart';
import '../../data/repos/transactions_repo.dart';
import '../../domain/usecases/cancel_transaction_usecase.dart';
import '../../domain/usecases/pay_back_transaction_usecase.dart';
import 'transactions_state.dart';

@injectable
class TransactionsCubit extends Cubit<TransactionsState>{

  TransactionsCubit({required this.transactionRepo})
      : cancelTransactionUseCase = CancelTransactionUseCase(transactionRepo),
        payBackTransactionUseCase = PayBackTransactionUseCase(transactionRepo),
        super(const TransactionsState());
  final TransactionsRepo transactionRepo;
  final CancelTransactionUseCase cancelTransactionUseCase;
  final PayBackTransactionUseCase payBackTransactionUseCase;

  Future<void> fetchTransactionList({required TransactionsEnum transaction}) async {
    emit(state.copyWith(transactionsStatus: RequestStatus.loading, currentFilter: transaction));
    final result = await transactionRepo.getTransactionList(transaction: transaction, page: 1);
    result.fold(
      (failure) => emit(
        state.copyWith(
          transactionsStatus: RequestStatus.error,
          message: failure.message,
        ), 
      ),
      (transactionsResponse) {
        final hasReachedMax = _checkIfReachedMax(transactionsResponse);
        emit(
          state.copyWith(
            transactionsStatus: RequestStatus.success,
            transactionsResponse: transactionsResponse,
            transactionsList: transactionsResponse.transactionsList ?? [],
            transactions: transactionsResponse.transactionsList,
            currentPage: 1,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  Future<void> loadMoreTransactions() async {
    if (state.hasReachedMax || state.isLoadingMore) return;

    emit(state.copyWith(transactionsStatus: RequestStatus.loadingMore));

    final nextPage = state.currentPage + 1;
    final result = await transactionRepo.getTransactionList(transaction: state.currentFilter, page: nextPage);

    result.fold(
      (failure) => emit(
        state.copyWith(
          transactionsStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (transactionsResponse) {
        final newTransactions = transactionsResponse.transactionsList ?? [];
        final updatedList = List<TransactionModel>.from(state.transactionsList)..addAll(newTransactions);
        
        final hasReachedMax = _checkIfReachedMax(transactionsResponse) || newTransactions.isEmpty;

        emit(
          state.copyWith(
            transactionsStatus: RequestStatus.success,
            transactionsResponse: transactionsResponse,
            transactionsList: updatedList,
            transactions: updatedList,
            currentPage: nextPage,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  Future<void> refreshTransactions() async {
    emit(state.copyWith(transactionsStatus: RequestStatus.refreshing));

    final result = await transactionRepo.getTransactionList(transaction: state.currentFilter, page: 1);
    result.fold(
      (failure) => emit(
        state.copyWith(
          transactionsStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (transactionsResponse) {
        final hasReachedMax = _checkIfReachedMax(transactionsResponse);
        emit(
          state.copyWith(
            transactionsStatus: RequestStatus.success,
            transactionsResponse: transactionsResponse,
            transactionsList: transactionsResponse.transactionsList ?? [],
            transactions: transactionsResponse.transactionsList,
            currentPage: 1,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  bool _checkIfReachedMax(TransactionsResponseModel transactionsResponse) {
    if (transactionsResponse.meta == null) return true;

    final currentPage = transactionsResponse.meta!.currentPage ?? 1;
    final lastPage = transactionsResponse.meta!.lastPage ?? 1;

    return currentPage >= lastPage;
  }
  
  // Legacy support
  Future<void> getTransactionList({required TransactionsEnum transaction}) async {
    await fetchTransactionList(transaction: transaction);
  }

  Future<void> showTransactionDetails({required String transactionId}) async {
    emit(state.copyWith(transactionDetailsStatus: RequestStatus.loading));
    final result = await transactionRepo.showTransactionDetails(transactionId: transactionId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          transactionDetailsStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (transaction) => emit(
        state.copyWith(
          transactionDetailsStatus: RequestStatus.success,
          transactionDetails: transaction,
        ),
      ),
    );
  }

  Future<void> updateTransactionStatus({required int transactionId, required UpdateTransactionRequestParams params}) async {
    emit(state.copyWith(updateTransactionRequestStatus: RequestStatus.loading));
    final result = await transactionRepo.updateTransactionStatus(transactionId: transactionId, params: params);
    result.fold(
      (failure) => emit(state.copyWith(updateTransactionRequestStatus: RequestStatus.error, message: failure.message)),
      (message) => emit(state.copyWith(updateTransactionRequestStatus: RequestStatus.success, message: message)),
    );
  }

  Future<void> cancelTransaction({required int transactionId}) async {
    emit(state.copyWith(cancelTransactionStatus: RequestStatus.loading));
    final result = await cancelTransactionUseCase(transactionId: transactionId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          cancelTransactionStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (message) => emit(
        state.copyWith(
          cancelTransactionStatus: RequestStatus.success,
          message: message,
        ),
      ),
    );
  }

  Future<void> payBackTransaction({required String transactionId}) async {
    emit(state.copyWith(payBackTransactionStatus: RequestStatus.loading));
    final result = await payBackTransactionUseCase(
      transactionId: transactionId,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          payBackTransactionStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (message) => emit(
        state.copyWith(
          payBackTransactionStatus: RequestStatus.success,
          message: message,
        ),
      ),
    );
  }
}