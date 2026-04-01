import 'package:alalamia/features/transactions/data/models/transaction_details_model.dart';
import 'package:alalamia/features/transactions/data/models/transaction_model.dart';
import 'package:alalamia/features/transactions/data/models/update_transaction_request_params.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/database/network/failure.dart';
import '../../../../core/enums/transactions_enum.dart';

abstract class TransactionsRepo {
  Future<Either<Failure, TransactionsResponseModel>> getTransactionList({required TransactionsEnum transaction, int page = 1});
  Future<Either<Failure, TransactionDetailsModel>> showTransactionDetails({required String transactionId});  
  Future<Either<Failure, String>> updateTransactionStatus({required UpdateTransactionRequestParams params , required int transactionId});
  Future<Either<Failure, String>> cancelTransaction({required int transactionId});
}