import 'package:alalamia/core/enums/request_status.dart';
import 'package:equatable/equatable.dart';

class ExpensesState extends Equatable {
  final RequestStatus expensesStatus;
  final String? message;

  const ExpensesState({
    this.expensesStatus = RequestStatus.initial,
    this.message,
  });

  ExpensesState copyWith({RequestStatus? expensesStatus, String? message}) {
    return ExpensesState(
      expensesStatus: expensesStatus ?? this.expensesStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [expensesStatus, message];
}
