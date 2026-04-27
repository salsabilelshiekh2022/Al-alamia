import 'package:alalamia/core/database/network/api_consumer.dart';
import 'package:alalamia/features/transactions/data/models/update_transaction_request_params.dart';
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
  Future<Either<Failure, TransactionsResponseModel>> getTransactionList({
    required TransactionsEnum transaction,
    int page = 1,
    List<String>? status,
    String? fromDate,
    String? toDate,
    String? search,
  }) async {
    final queryParameters = <String, dynamic>{
      'type': transaction.name,
      'page': page,
    };

    final normalizedStatus = status
        ?.map((value) => value.trim())
        .where((value) => value.isNotEmpty)
        .toList();
    if (normalizedStatus != null && normalizedStatus.isNotEmpty) {
      queryParameters['status[]'] = normalizedStatus;
    }

    final normalizedFromDate = fromDate?.trim();
    if (normalizedFromDate != null && normalizedFromDate.isNotEmpty) {
      queryParameters['from_date'] = normalizedFromDate;
    }

    final normalizedToDate = toDate?.trim();
    if (normalizedToDate != null && normalizedToDate.isNotEmpty) {
      queryParameters['to_date'] = normalizedToDate;
    }

    final normalizedSearch = search?.trim();
    if (normalizedSearch != null && normalizedSearch.isNotEmpty) {
      queryParameters['search'] = normalizedSearch;
    }

    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(
        EndPoints.getTransactionList(),
        queryParameters: queryParameters,
      ),
      onSuccess: (result) {
        return TransactionsResponseModel.fromJson(result);
      },
    );
  }

  @override
  Future<Either<Failure, TransactionDetailsModel>> showTransactionDetails({
    required String transactionId,
  }) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(
        EndPoints.showTransactionDetails(transactionId: transactionId),
      ),
      onSuccess: (result) {
        final data = result['data'];
        final meta = result['meta'];
        return TransactionDetailsModel.fromJson(data, pdfUrl: meta?['pdf_url']);
      },
    );
  }

  @override
  Future<Either<Failure, String>> updateTransactionStatus({
    required UpdateTransactionRequestParams params,
    required int transactionId,
  }) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.updateTransactionStatus(transactionId: transactionId),
        data: params.toJson(),
      ),
      onSuccess: (result) {
        return result['meta']['message'] ?? 'Success';
      },
    );
  }

  @override
  Future<Either<Failure, String>> cancelTransaction({
    required int transactionId,
  }) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.cancelTransaction(transactionId: transactionId),
      ),
      onSuccess: (result) {
        return result['meta']?['message'] ?? 'Success';
      },
    );
  }

  @override
  Future<Either<Failure, String>> payBackTransaction({
    required String transactionId,
  }) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.payBackTransaction(transactionId: transactionId),
      ),
      onSuccess: (result) {
        return result['meta']?['message'] ?? 'Success';
      },
    );
  }
}
