import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/network/api_consumer.dart';
import '../../../../core/database/network/end_points.dart';
import '../../../../core/database/network/failure.dart';
import '../models/in_and_out_request_params.dart';
import 'in_and_out_repo.dart';

@LazySingleton(as: InAndOutRepo)
class InAndOutRepoImpl extends InAndOutRepo {
  final ApiConsumer apiConsumer;

  InAndOutRepoImpl({ required this.apiConsumer});
  @override
  Future<Either<Failure, String>> inAndOutTransaction({
    required InAndOutRequestParams params,
  }) {
     return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.inAndOutTransaction,
        data: params.toJson(),
      ),
      onSuccess: (result) {
        return result['message'] ?? 'تمت العملية بنجاح';
      },
    );
  }
}