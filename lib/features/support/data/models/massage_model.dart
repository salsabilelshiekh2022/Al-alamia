class MessageModel {
  final int id;
  final String sender;
  final String senderType;
  final String message;
  final String createdAt;

  MessageModel({
    required this.id,
    required this.sender,
    required this.senderType,
    required this.message,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      sender: json['sender'],
      senderType: json['sender_type'],
      message: json['message'],
      createdAt: json['created_at'],
    );
  }
}
