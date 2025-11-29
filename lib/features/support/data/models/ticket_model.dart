import 'package:alalamia/core/enums/support_ticket_status_enum.dart';

class TicketModel {
  final String title;
  final String description;
  final DateTime date;
  final SupportTicketStatusEnum status;

  TicketModel({
    required this.title,
    required this.description,
    required this.date,
    required this.status,
  });
}

List<TicketModel> ticketsData = [
  TicketModel(
    title: "مشكلة في عملية التحويل",
    description: "تم رفض التحويل بدون سبب واضح",
    date: DateTime.now().subtract(Duration(days: 1)),
    status: SupportTicketStatusEnum.open,
  ),
  TicketModel(
    title: "مشكلة في الرسوم",
    description: "تم خصم رسوم إضافية غير متفق عليها.",
    date: DateTime.now().subtract(Duration(days: 3)),
    status: SupportTicketStatusEnum.closed,
  ),
  TicketModel(
    title: "خطأ في معلومات العميل",
    description: "بيانات العميل غير صحيحة في النظام",
    date: DateTime.now().subtract(Duration(days: 5)),
    status: SupportTicketStatusEnum.open,
  ),
  TicketModel(
    title: "تأخير في استلام الأموال",
    description: "العميل لم يستلم المبلغ بعد مرورو 24 ساعة",
    date: DateTime.now().subtract(Duration(days: 3)),
    status: SupportTicketStatusEnum.closed,
  ),
];
