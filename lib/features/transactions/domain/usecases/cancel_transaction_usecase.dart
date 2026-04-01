import 'package:dartz/dartz.dart';

import '../../../../core/database/network/failure.dart';
import '../../data/repos/transactions_repo.dart';

class CancelTransactionUseCase {
  const CancelTransactionUseCase(this.transactionsRepo);

  final TransactionsRepo transactionsRepo;

  Future<Either<Failure, String>> call({required int transactionId}) {
    return transactionsRepo.cancelTransaction(transactionId: transactionId);
  }
}
