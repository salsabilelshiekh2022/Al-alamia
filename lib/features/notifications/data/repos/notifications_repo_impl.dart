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
  Future<Either<Failure, List<NotificationModel>>> fetchNotifications() {
      return apiConsumer.handleRequest(
      request: () => apiConsumer.get(EndPoints.getNotifications),
      onSuccess: (result) {
        final data = result['data'] as List;
        return data.map((e) => NotificationModel.fromJson(e)).toList();
      },
    );
  }
  
}