import 'package:alalamia/core/enums/request_status.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/debt_model.dart';

class DebtsState extends Equatable {
  final RequestStatus debtsStatus;
  final RequestStatus getDebtsByCurrencyStatus;
  final String? message;
  final int? debtsAmountByCurrency;
  final List<DebtModel>? debtsTransactions;
  
  // Pagination fields
  final DebtsResponseModel? debtsResponse;
  final List<DebtModel> debtsList;
  final int currentPage;
  final bool hasReachedMax;

  const DebtsState({
    this.debtsStatus = RequestStatus.initial,
    this.message,
    this.debtsAmountByCurrency,
    this.debtsTransactions,
    this.getDebtsByCurrencyStatus = RequestStatus.initial,
    this.debtsResponse,
    this.debtsList = const [],
    this.currentPage = 1,
    this.hasReachedMax = false,
  });

  DebtsState copyWith({
    RequestStatus? debtsStatus,
    String? message,
    int? debtsAmountByCurrency,
    List<DebtModel>? debtsTransactions,
    RequestStatus? getDebtsByCurrencyStatus,
    DebtsResponseModel? debtsResponse,
    List<DebtModel>? debtsList,
    int? currentPage,
    bool? hasReachedMax,
  }) {
    return DebtsState(
      debtsStatus: debtsStatus ?? this.debtsStatus,
      message: message ?? this.message,
      debtsAmountByCurrency: debtsAmountByCurrency ?? this.debtsAmountByCurrency,
      debtsTransactions: debtsTransactions ?? this.debtsTransactions,
      getDebtsByCurrencyStatus: getDebtsByCurrencyStatus ?? this.getDebtsByCurrencyStatus,
      debtsResponse: debtsResponse ?? this.debtsResponse,
      debtsList: debtsList ?? this.debtsList,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  // Helper getters
  bool get isInitial => debtsStatus == RequestStatus.initial;
  bool get isLoading => debtsStatus == RequestStatus.loading;
  bool get isLoadingMore => debtsStatus == RequestStatus.loadingMore;
  bool get isSuccess => debtsStatus == RequestStatus.success;
  bool get isFailure => debtsStatus == RequestStatus.error;
  bool get isRefreshing => debtsStatus == RequestStatus.refreshing;

  @override
  List<Object?> get props => [
        debtsStatus,
        message,
        debtsAmountByCurrency,
        debtsTransactions,
        getDebtsByCurrencyStatus,
        debtsResponse,
        debtsList,
        currentPage,
        hasReachedMax,
      ];
}
