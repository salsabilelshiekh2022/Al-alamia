import 'package:alalamia/core/enums/request_status.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/transaction_model.dart';

class TransactionsState extends Equatable{
  final RequestStatus transactionsStatus;
  final String? message;
  final List<TransactionModel>? transactions;
  const TransactionsState({ this.transactionsStatus = RequestStatus.initial, this.message, this.transactions});
  
  TransactionsState copyWith({RequestStatus? transactionsStatus, String? message , List<TransactionModel>? transactions}) {
    return TransactionsState(
      transactionsStatus: transactionsStatus ?? this.transactionsStatus,
      message: message ?? this.message,
      transactions: transactions ?? this.transactions
    );
  }
  
  @override
 
  List<Object?> get props => [transactionsStatus, message, transactions];
}