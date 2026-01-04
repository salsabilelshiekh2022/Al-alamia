import 'package:alalamia/core/database/network/api_consumer.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/network/end_points.dart';
import '../../../../core/database/network/failure.dart';
import '../../../../core/enums/transactions_enum.dart';
import '../models/transaction_details_model.dart';
import '../models/transaction_model.dart';
import 'transactions_repo.dart';

@LazySingleton(as: TransactionsRepo)
class TransactionsRepoImpl implements TransactionsRepo {
final ApiConsumer apiConsumer;

  TransactionsRepoImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, List<TransactionModel>>> getTransactionList(
      {required TransactionsEnum transaction}) async {
   return apiConsumer.handleRequest(
      request: () => apiConsumer.get(EndPoints.getTransactionList(transaction: transaction)),
      onSuccess: (result) {
        final data = result['data'] as List;
        return data.map((e) => TransactionModel.fromJson(e)).toList();
      },
    );
  }
  
  @override
  Future<Either<Failure, TransactionDetailsModel>> showTransactionDetails({required String transactionId}) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(EndPoints.showTransactionDetails(transactionId: transactionId)),
      onSuccess: (result) {
        final data = result['data'];
        final meta = result['meta'];
        return TransactionDetailsModel.fromJson(data, pdfUrl: meta?['pdf_url']);
      },
    );
  }
  
}