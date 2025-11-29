import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:flutter/material.dart';

import '../../../data/models/ticket_model.dart';
import 'ticket_card.dart';

class TicketsList extends StatelessWidget {
  const TicketsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final ticket = ticketsData[index];
        return TicketCard(ticket: ticket);
      },
      separatorBuilder: (context, index) => 16.verticalSizedBox,
      itemCount: ticketsData.length,
    );
  }
}
