import 'package:equatable/equatable.dart';

import '../../../../core/enums/request_status.dart';
import '../../data/models/notification_model.dart';

class NotificationState extends Equatable {
  final RequestStatus status;
  final NotificationsResponseModel? notifications;
  final List<NotificationModel> notificationList;
  final String? errorMessage;
  final bool hasReachedMax;
  final int currentPage;

  const NotificationState({
    this.status = RequestStatus.initial,
    this.notifications,
    this.notificationList = const [],
    this.errorMessage,
    this.hasReachedMax = false,
    this.currentPage = 1,
  });

  NotificationState copyWith({
    RequestStatus? status,
    NotificationsResponseModel? notifications,
    List<NotificationModel>? notificationList,
    String? errorMessage,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      notificationList: notificationList ?? this.notificationList,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  bool get isInitial => status == RequestStatus.initial;
  bool get isLoading => status == RequestStatus.loading;
  bool get isLoadingMore => status == RequestStatus.loadingMore;
  bool get isSuccess => status == RequestStatus.success;
  bool get isFailure => status == RequestStatus.error;
  bool get isRefreshing => status == RequestStatus.refreshing;

  bool get isEmpty => isSuccess && notificationList.isEmpty;
  bool get isNotEmpty => isSuccess && notificationList.isNotEmpty;
  int get totalNotifications => notifications?.meta?.total ?? 0;

  @override
  List<Object?> get props => [
        status,
        notifications,
        notificationList,
        errorMessage,
        hasReachedMax,
        currentPage,
      ];
}
