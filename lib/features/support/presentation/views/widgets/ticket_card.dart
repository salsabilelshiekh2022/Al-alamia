import 'package:alalamia/core/enums/support_ticket_status_enum.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/features/support/data/models/ticket_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/components/widgets/card_with_gray_border.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.ticket});
  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    return CardWithGrayBorder(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                ticket.title,
                style: context.textStyles.font15SemiBoldSecondaryColor,
              ),
              Spacer(),
              _buildStatusBox(context, ticket.status),
            ],
          ),
          4.verticalSizedBox,
          Text(
            ticket.description,
            style: context.textStyles.font14RegularGrayColor,
          ),
          10.verticalSizedBox,
          Text(
            DateFormat(
              'dd-MM-yyyy , hh:mm a',
              EasyLocalization.of(context)!.locale.languageCode,
            ).format(ticket.date).toString(),
            style: context.textStyles.font14RegularGrayColor,
          ),
        ],
      ),
    );
  }

  Container _buildStatusBox(
    BuildContext context,
    SupportTicketStatusEnum status,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: status == SupportTicketStatusEnum.open
            ? context.colors.greenColor.withValues(alpha: 0.1)
            : context.colors.redColor.withValues(alpha: 0.1),
        borderRadius: 6.allBorderRadius,
      ),
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        children: [
          Icon(
            status == SupportTicketStatusEnum.open
                ? Icons.error_outline_rounded
                : Icons.check_circle_outline_rounded,
            size: 14,
            color: status == SupportTicketStatusEnum.open
                ? context.colors.greenColor
                : context.colors.redColor,
          ),
          2.horizontalSizedBox,
          Text(
            ticket.status.translate(context),
            style: context.textStyles.font14MediumGrayColor.copyWith(
              color: status == SupportTicketStatusEnum.open
                  ? context.colors.greenColor
                  : context.colors.redColor,
            ),
          ),
        ],
      ),
    );
  }
}
