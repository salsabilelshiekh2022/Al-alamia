import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/features/expenses/data/models/expense_model.dart';
import 'package:equatable/equatable.dart';

class ExpensesState extends Equatable {
  final RequestStatus expensesStatus;
  final String? message;
  final List<ExpenseModel?>? expenses ;
  final String? expensesAmountByCurrency;

  const ExpensesState({
    this.expensesStatus = RequestStatus.initial,
    this.message,
    this.expenses,
    this.expensesAmountByCurrency
  });

  ExpensesState copyWith({RequestStatus? expensesStatus, String? message , List<ExpenseModel?>? expenses, String? expensesAmountByCurrency}) {
    return ExpensesState(
      expensesStatus: expensesStatus ?? this.expensesStatus,
      message: message ?? this.message,
      expenses: expenses ?? this.expenses
      , expensesAmountByCurrency: expensesAmountByCurrency ?? this.expensesAmountByCurrency
    );
  }

  @override
  List<Object?> get props => [expensesStatus, message, expenses, expensesAmountByCurrency];
}
