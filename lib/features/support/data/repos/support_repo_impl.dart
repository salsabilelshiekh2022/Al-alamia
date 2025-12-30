import 'package:alalamia/core/database/network/api_consumer.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/network/end_points.dart';
import '../../../../core/database/network/failure.dart';
import '../models/massage_model.dart';
import 'support_repo.dart';

@LazySingleton(as: SupportRepo)
class SupportRepoImpl extends SupportRepo {
  final ApiConsumer apiConsumer;
  SupportRepoImpl({required this.apiConsumer});
  @override
  Future<Either<Failure, String>> sendMessage({required String message}) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.sendMessage,
        data: {'message': message},
      ),
      onSuccess: (result) {
        return result['meta']['message'] ?? 'Success';
      },
    );
  }

  @override
  Future<Either<Failure, List<MessageModel>>> gettMessages() {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(EndPoints.getMessages),
      onSuccess: (result) {
        final data = result['data'] as List;
        return data.map((e) => MessageModel.fromJson(e)).toList();
      },
    );
  }
}
