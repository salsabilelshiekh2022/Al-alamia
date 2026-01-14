/// Response structure for paginated notifications API
class NotificationsResponseModel {
  final List<NotificationModel>? notificationsList;
  final Meta? meta;
  final bool? success;

  NotificationsResponseModel({
    this.notificationsList,
    this.meta,
    this.success,
  });

  factory NotificationsResponseModel.fromJson(Map<String, dynamic> json) {
    return NotificationsResponseModel(
      notificationsList: json['data'] != null
          ? (json['data'] as List)
              .map((v) => NotificationModel.fromJson(v))
              .toList()
          : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      success: json['success'],
    );
  }
}

/// Individual notification item model
class NotificationModel {
  final int id;
  final String title;
  final String body;
  final String? type;
  final String status;
  final String createdAt;
  final bool isSeen;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    this.type,
    required this.status,
    required this.createdAt,
    required this.isSeen,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      type: json['type'],
      status: json['status'],
      createdAt: json['created_at'],
      isSeen: json['is_seen'],
    );
  }
}

class Meta {
  final int? currentPage;
  final int? from;
  final int? lastPage;
  final String? path;
  final int? perPage;
  final int? to;
  final int? total;
  final String? message;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
    this.message,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      path: json['path'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
      message: json['message'],
    );
  }
}

NotificationModel dummyNotificationModel = NotificationModel(
  id: 0,
  title: 'Sample Notification',
  body: 'This is a sample notification body for testing purposes.',
  type: null,
  status: 'info',
  createdAt: '2023-01-01 00:00:00',
  isSeen: false,
);