import 'package:flutter/material.dart';

import '../../../../../core/helper/app_extention.dart';
import '../../../../../core/helper/number_extentions.dart';
import '../../../../../core/helper/translation_extensions.dart';
import 'currency_balance_item_in_reports.dart';

class WalletInReports extends StatelessWidget {
  const WalletInReports({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.wallet,
          style: context.textStyles.font16SemiBoldSecondaryColor,
        ),
        12.verticalSizedBox,
        Column(
           children: List.generate(3, (index) => CurrencyBalanceItemInReports()).toList(),
         )

        ],
    );
  }
}
