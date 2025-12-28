  //  {
  //             "id": 31,
  //             "title": "Sed nemo labore aut.",
  //             "body": "Laborum eligendi dicta enim est provident incidunt inventore maxime voluptas sequi quia totam.",
  //             "type": null,
  //             "status": "danger",
  //             "created_at": "27-12-2025 22:42:20",
  //             "is_seen": true
  //         },

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