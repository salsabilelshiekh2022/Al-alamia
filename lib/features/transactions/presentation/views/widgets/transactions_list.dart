import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:flutter/material.dart';

import 'transaction_card.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) => TransactionCard(),
      separatorBuilder: (context, index) => 16.verticalSizedBox,
    );
  }
}