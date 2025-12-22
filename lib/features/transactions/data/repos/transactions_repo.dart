import 'package:alalamia/features/transactions/data/models/transaction_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/database/network/failure.dart';
import '../../../../core/enums/transactions_enum.dart';

abstract class TransactionsRepo {
  Future<Either<Failure, List<TransactionModel>>> getTransactionList({required TransactionsEnum transaction});
}