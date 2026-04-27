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
class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit({required this.transactionRepo})
    : cancelTransactionUseCase = CancelTransactionUseCase(transactionRepo),
      payBackTransactionUseCase = PayBackTransactionUseCase(transactionRepo),
      super(const TransactionsState());
  final TransactionsRepo transactionRepo;
  final CancelTransactionUseCase cancelTransactionUseCase;
  final PayBackTransactionUseCase payBackTransactionUseCase;

  List<String>? _statusFilters;
  String? _fromDateFilter;
  String? _toDateFilter;
  String? _searchFilter;

  List<String>? get statusFilters =>
      _statusFilters == null ? null : List.unmodifiable(_statusFilters!);
  String? get fromDateFilter => _fromDateFilter;
  String? get toDateFilter => _toDateFilter;
  String? get searchFilter => _searchFilter;

  String? _normalizeQueryValue(String? value) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) {
      return null;
    }
    return normalized;
  }

  List<String>? _normalizeStatusFilters(List<String>? statuses) {
    if (statuses == null) {
      return null;
    }

    final normalized = statuses
        .map((status) => status.trim())
        .where((status) => status.isNotEmpty)
        .toList();

    if (normalized.isEmpty) {
      return null;
    }

    return normalized;
  }

  Future<void> fetchTransactionList({
    required TransactionsEnum transaction,
    List<String>? status,
    String? fromDate,
    String? toDate,
    String? search,
  }) async {
    final normalizedStatus = _normalizeStatusFilters(status);
    final normalizedFromDate = _normalizeQueryValue(fromDate);
    final normalizedToDate = _normalizeQueryValue(toDate);
    final normalizedSearch = _normalizeQueryValue(search);

    _statusFilters = normalizedStatus;
    _fromDateFilter = normalizedFromDate;
    _toDateFilter = normalizedToDate;
    _searchFilter = normalizedSearch;

    emit(
      state.copyWith(
        transactionsStatus: RequestStatus.loading,
        currentFilter: transaction,
      ),
    );

    final result = await transactionRepo.getTransactionList(
      transaction: transaction,
      page: 1,
      status: _statusFilters,
      fromDate: _fromDateFilter,
      toDate: _toDateFilter,
      search: _searchFilter,
    );

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
    final result = await transactionRepo.getTransactionList(
      transaction: state.currentFilter,
      page: nextPage,
      status: _statusFilters,
      fromDate: _fromDateFilter,
      toDate: _toDateFilter,
      search: _searchFilter,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          transactionsStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (transactionsResponse) {
        final newTransactions = transactionsResponse.transactionsList ?? [];
        final updatedList = List<TransactionModel>.from(state.transactionsList)
          ..addAll(newTransactions);

        final hasReachedMax =
            _checkIfReachedMax(transactionsResponse) || newTransactions.isEmpty;

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

    final result = await transactionRepo.getTransactionList(
      transaction: state.currentFilter,
      page: 1,
      status: _statusFilters,
      fromDate: _fromDateFilter,
      toDate: _toDateFilter,
      search: _searchFilter,
    );
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
  Future<void> getTransactionList({
    required TransactionsEnum transaction,
    List<String>? status,
    String? fromDate,
    String? toDate,
    String? search,
  }) async {
    await fetchTransactionList(
      transaction: transaction,
      status: status,
      fromDate: fromDate,
      toDate: toDate,
      search: search,
    );
  }

  Future<void> showTransactionDetails({required String transactionId}) async {
    emit(state.copyWith(transactionDetailsStatus: RequestStatus.loading));
    final result = await transactionRepo.showTransactionDetails(
      transactionId: transactionId,
    );
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

  Future<void> updateTransactionStatus({
    required int transactionId,
    required UpdateTransactionRequestParams params,
  }) async {
    emit(state.copyWith(updateTransactionRequestStatus: RequestStatus.loading));
    final result = await transactionRepo.updateTransactionStatus(
      transactionId: transactionId,
      params: params,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          updateTransactionRequestStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (message) => emit(
        state.copyWith(
          updateTransactionRequestStatus: RequestStatus.success,
          message: message,
        ),
      ),
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
