import 'package:equatable/equatable.dart';

import '../../../../core/enums/request_status.dart';
import '../../data/models/notification_model.dart';

class NotificationState extends Equatable {
  final RequestStatus getNotificationsStatus;
  final List<NotificationModel?>? notifications;
  final String? message;

  const NotificationState({
    this.getNotificationsStatus = RequestStatus.initial,
    this.notifications ,
    this.message,
  });
  
  

  NotificationState copyWith({
    RequestStatus? getNotificationsStatus,
    List<NotificationModel?>? notifications,
    String? message
  }) {
    return NotificationState(
      getNotificationsStatus:
          getNotificationsStatus ?? this.getNotificationsStatus,
      notifications: notifications ?? this.notifications,
      message: message ?? this.message,
    );
  }
  
  @override
  List<Object?> get props => [getNotificationsStatus, notifications, message];

  
}
