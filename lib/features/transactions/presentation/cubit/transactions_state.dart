import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/features/transactions/data/models/transaction_details_model.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/transaction_model.dart';

class TransactionsState extends Equatable{
  final RequestStatus transactionsStatus;
  final RequestStatus transactionDetailsStatus;
  final String? message;
  final List<TransactionModel>? transactions;
  final TransactionDetailsModel ? transactionDetails;
  const TransactionsState({ this.transactionsStatus = RequestStatus.initial, this.transactionDetailsStatus = RequestStatus.initial, this.message, this.transactions, this.transactionDetails });
  
  TransactionsState copyWith({RequestStatus? transactionsStatus, RequestStatus? transactionDetailsStatus, String? message , List<TransactionModel>? transactions, TransactionDetailsModel? transactionDetails}) {
    return TransactionsState(
      transactionsStatus: transactionsStatus ?? this.transactionsStatus,
      transactionDetailsStatus: transactionDetailsStatus ?? this.transactionDetailsStatus,
      message: message ?? this.message,
      transactions: transactions ?? this.transactions,
      transactionDetails: transactionDetails ?? this.transactionDetails
    );
  }
  
  @override

  List<Object?> get props => [transactionsStatus, transactionDetailsStatus, message, transactions, transactionDetails];
}