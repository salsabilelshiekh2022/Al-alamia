import 'package:alalamia/core/database/network/failure.dart';
import 'package:dartz/dartz.dart';

import '../models/notification_model.dart';

abstract class NotificationsRepo {
Future<Either <Failure, List<NotificationModel>>> fetchNotifications();

}