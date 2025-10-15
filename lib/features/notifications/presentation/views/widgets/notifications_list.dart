import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:flutter/material.dart';

import 'notification_card.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key});
 
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => NotificationCard(), itemCount: 10,
    separatorBuilder: (context, index) => 16.verticalSizedBox,
    );
  }
}