import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/features/transactions/data/models/transaction_details_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/enums/transactions_enum.dart';
import '../../data/models/transaction_model.dart';

class TransactionsState extends Equatable{
  final RequestStatus transactionsStatus;
  final RequestStatus transactionDetailsStatus;
  final String? message;
  final List<TransactionModel>? transactions;
  final TransactionDetailsModel ? transactionDetails;
  final RequestStatus updateTransactionRequestStatus;
  
  // Pagination fields
  final TransactionsResponseModel? transactionsResponse;
  final List<TransactionModel> transactionsList;
  final int currentPage;
  final bool hasReachedMax;
  final TransactionsEnum currentFilter;

  const TransactionsState({ 
    this.transactionsStatus = RequestStatus.initial, 
    this.transactionDetailsStatus = RequestStatus.initial, 
    this.message, 
    this.transactions, 
    this.transactionDetails, 
    this.updateTransactionRequestStatus = RequestStatus.initial,
    this.transactionsResponse,
    this.transactionsList = const [],
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.currentFilter = TransactionsEnum.recieving,
  });
  
  TransactionsState copyWith({
    RequestStatus? transactionsStatus, 
    RequestStatus? transactionDetailsStatus, 
    String? message , 
    List<TransactionModel>? transactions, 
    TransactionDetailsModel? transactionDetails, 
    RequestStatus? updateTransactionRequestStatus,
    TransactionsResponseModel? transactionsResponse,
    List<TransactionModel>? transactionsList,
    int? currentPage,
    bool? hasReachedMax,
    TransactionsEnum? currentFilter,
  }) {
    return TransactionsState(
      transactionsStatus: transactionsStatus ?? this.transactionsStatus,
      transactionDetailsStatus: transactionDetailsStatus ?? this.transactionDetailsStatus,
      message: message ?? this.message,
      transactions: transactions ?? this.transactions,
      transactionDetails: transactionDetails ?? this.transactionDetails,
      updateTransactionRequestStatus: updateTransactionRequestStatus ?? this.updateTransactionRequestStatus,
      transactionsResponse: transactionsResponse ?? this.transactionsResponse,
      transactionsList: transactionsList ?? this.transactionsList,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentFilter: currentFilter ?? this.currentFilter,
    );
  }

  // Helper getters
  bool get isLoading => transactionsStatus == RequestStatus.loading;
  bool get isLoadingMore => transactionsStatus == RequestStatus.loadingMore;
  bool get isSuccess => transactionsStatus == RequestStatus.success;
  bool get isFailure => transactionsStatus == RequestStatus.error;
  bool get isRefreshing => transactionsStatus == RequestStatus.refreshing;
  bool get isInitial => transactionsStatus == RequestStatus.initial;
  
  @override

  List<Object?> get props => [
    transactionsStatus, 
    transactionDetailsStatus, 
    message, 
    transactions, 
    transactionDetails, 
    updateTransactionRequestStatus,
    transactionsResponse,
    transactionsList,
    currentPage,
    hasReachedMax,
    currentFilter,
  ];
}