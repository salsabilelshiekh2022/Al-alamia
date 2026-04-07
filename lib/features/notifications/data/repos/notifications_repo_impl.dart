import 'package:alalamia/core/database/network/api_consumer.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/database/network/end_points.dart';
import '../../../../core/database/network/failure.dart';
import '../models/notification_model.dart';
import 'notifications_repo.dart';

import 'package:injectable/injectable.dart';

@LazySingleton(as: NotificationsRepo)
class NotificationsRepoImpl extends NotificationsRepo {
  final ApiConsumer apiConsumer;
  NotificationsRepoImpl({required this.apiConsumer});
  @override
  Future<Either<Failure, NotificationsResponseModel>> fetchNotifications({
    int page = 1,
  }) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(
        EndPoints.getNotifications,
        queryParameters: {'page': page},
      ),
      onSuccess: (result) {
        return NotificationsResponseModel.fromJson(result);
      },
    );
  }

  @override
  Future<Either<Failure, String>> toggleNotification() {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(path: EndPoints.toggleNotifications),
      onSuccess: (result) {
        if (result is Map<String, dynamic>) {
          return result['message'] ?? 'Success';
        }
        return 'Success';
      },
    );
  }
}
