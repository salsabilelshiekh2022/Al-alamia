import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/features/transactions/presentation/views/widgets/transaction_From_to.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/card_with_gray_border.dart';
import '../../../../../core/enums/transactions_status_enum.dart';
import 'transaction_status_box.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWithGrayBorder(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "# 12345678",
                    style: context.textStyles.font16RegularSecondaryColor,
                  ),
                  6.verticalSpace,
                  Text(
                    "2024-10-05, 12:30 م",
                    style: context.textStyles.font14MediumGrayColor,
                  ),
                ],
              ),
              Spacer(),
              TransactionStatusBox(status: TransactionsStatusEnum.success),
            
            ],
          ),
            Divider(
                color: context.colors.strokeColor,
                thickness: 1,).verticalPadding(10),
                TransactionFromTo(),
                  16.verticalSizedBox,
        Text("\$1,250.30+", style:  context.textStyles.font20SemiBoldPrimaryColor,)
        ],
      ),
    );
  }
}