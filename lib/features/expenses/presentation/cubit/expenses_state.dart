import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/features/expenses/data/models/expense_model.dart';
import 'package:alalamia/features/expenses/data/models/expense_type_model.dart';
import 'package:equatable/equatable.dart';

class ExpensesState extends Equatable {
  final RequestStatus expensesStatus;
  final String? message;
  final List<ExpenseModel?>? expenses;
  final dynamic expensesAmountByCurrency;
  final List<ExpenseTypeModel> expenseTypes ;

  // Pagination fields
  final ExpensesResponseModel? expensesResponse;
  final List<ExpenseModel> expensesList;
  final int currentPage;
  final bool hasReachedMax;

  const ExpensesState({
    this.expensesStatus = RequestStatus.initial,
    this.message,
    this.expenses,
    this.expensesAmountByCurrency,
    this.expensesResponse,
    this.expensesList = const [],
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.expenseTypes = const [],
  });

  ExpensesState copyWith({
    RequestStatus? expensesStatus,
    String? message,
    List<ExpenseModel?>? expenses,
    dynamic expensesAmountByCurrency,
    ExpensesResponseModel? expensesResponse,
    List<ExpenseModel>? expensesList,
    int? currentPage,
    bool? hasReachedMax,
    List<ExpenseTypeModel>? expenseTypes,
  }) {
    return ExpensesState(
      expensesStatus: expensesStatus ?? this.expensesStatus,
      message: message ?? this.message,
      expenses: expenses ?? this.expenses,
      expensesAmountByCurrency: expensesAmountByCurrency ?? this.expensesAmountByCurrency,
      expensesResponse: expensesResponse ?? this.expensesResponse,
      expensesList: expensesList ?? this.expensesList,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      expenseTypes: expenseTypes ?? this.expenseTypes,
    );
  }
  
  // Helper getters
  bool get isInitial => expensesStatus == RequestStatus.initial;
  bool get isLoading => expensesStatus == RequestStatus.loading;
  bool get isLoadingMore => expensesStatus == RequestStatus.loadingMore;
  bool get isSuccess => expensesStatus == RequestStatus.success;
  bool get isFailure => expensesStatus == RequestStatus.error;
  bool get isRefreshing => expensesStatus == RequestStatus.refreshing;

  @override
  List<Object?> get props => [
        expensesStatus,
        message,
        expenses,
        expensesAmountByCurrency,
        expensesResponse,
        expensesList,
        currentPage,
        hasReachedMax,
        expenseTypes,
      ];
}
