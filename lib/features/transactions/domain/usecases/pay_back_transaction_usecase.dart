import 'package:dartz/dartz.dart';

import '../../../../core/database/network/failure.dart';
import '../../data/repos/transactions_repo.dart';

class PayBackTransactionUseCase {
  const PayBackTransactionUseCase(this.transactionsRepo);

  final TransactionsRepo transactionsRepo;

  Future<Either<Failure, String>> call({required String transactionId}) {
    return transactionsRepo.payBackTransaction(transactionId: transactionId);
  }
}
