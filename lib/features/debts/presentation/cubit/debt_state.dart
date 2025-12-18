import 'package:alalamia/core/enums/request_status.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/debt_model.dart';

class DebtsState extends Equatable {
  final RequestStatus debtsStatus;
  final RequestStatus getDebtsByCurrencyStatus;
  final String? message;
final int? debtsAmountByCurrency;
final List<DebtModel>? debtsTransactions;

  const DebtsState({this.debtsStatus = RequestStatus.initial, this.message, this.debtsAmountByCurrency, this.debtsTransactions, this.getDebtsByCurrencyStatus = RequestStatus.initial,});

  DebtsState copyWith({RequestStatus? debtsStatus, String? message, int? debtsAmountByCurrency, List<DebtModel>? debtsTransactions, RequestStatus? getDebtsByCurrencyStatus}) {
    return DebtsState(
      debtsStatus: debtsStatus ?? this.debtsStatus,
      message: message ?? this.message,
      debtsAmountByCurrency: debtsAmountByCurrency ?? this.debtsAmountByCurrency,
      debtsTransactions: debtsTransactions ?? this.debtsTransactions 
      , getDebtsByCurrencyStatus: getDebtsByCurrencyStatus ?? this.getDebtsByCurrencyStatus
    );
  }

  @override
  List<Object?> get props => [debtsStatus, message, debtsAmountByCurrency, debtsTransactions, getDebtsByCurrencyStatus];
}
