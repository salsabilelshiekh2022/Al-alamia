import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/enums/transactions_status_enum.dart';

class TransactionStatusBox extends StatelessWidget {
  const TransactionStatusBox({super.key, required this.status});
  final TransactionsStatusEnum status;

  Color _getBackgroundColor(BuildContext context) {
    return switch (status) {
      TransactionsStatusEnum.success => context.colors.greenColor.withValues(
        alpha: 0.06,
      ),
      TransactionsStatusEnum.pending => context.colors.yellowColor.withValues(
        alpha: 0.06,
      ),
      TransactionsStatusEnum.failed => context.colors.redColor.withValues(
        alpha: 0.06,
      ),
    };
  }

  Color _getTextColor(BuildContext context) {
    return switch (status) {
      TransactionsStatusEnum.success => context.colors.greenColor,
      TransactionsStatusEnum.pending => context.colors.yellowColor,
      TransactionsStatusEnum.failed => context.colors.redColor,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
     width: 80,
     height: 26,
      decoration: BoxDecoration(
        color: _getBackgroundColor(context),
        borderRadius: BorderRadius.circular(6.r),
       
      ),
      child: Text(
        status.translate(context),
        style: context.textStyles.font14MediumSecondaryColor.copyWith(
          color: _getTextColor(context),
        ),
      ).center(),
    );
  }
}

