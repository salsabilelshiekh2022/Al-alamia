import 'package:alalamia/features/expenses/data/models/expense_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/app_extention.dart';
import '../../../../../core/helper/number_extentions.dart';
import '../../../../transactions/presentation/views/widgets/transactions_details/card_with_shadow.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem( {super.key, required this.expenseModel,});
  final ExpenseModel  expenseModel;

  @override
  Widget build(BuildContext context) {
    return CardWithShadow(borderRadius: 12,padding: 14,
    child: Column(
      children: [
        Row(
          children: [
            _buildStatusBox(context),
            Spacer(),
            Text(DateFormat('d MMMM yyyy', EasyLocalization.of(context)!.locale.languageCode).format(expenseModel.createdAt ?? DateTime.now()),style: context.textStyles.font14MediumGrayColor,),
          ],
        ),
        16.verticalSizedBox,
        Row(
          children: [
            Text(expenseModel.employee?.name ?? "",style: context.textStyles.font15SemiBoldSecondaryColor,),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
              Text(expenseModel.currency?.code ?? "",style: context.textStyles.font13SemiBoldPrimaryColor.copyWith(color: context.colors.grayColor, fontWeight: FontWeight.w500),),
                Text(expenseModel.amount ?? "",style: context.textStyles.font16SemiBoldSecondaryColor,),
              ],
            )
          ],
        ),
        16.verticalSizedBox,
        Container(
          padding: 10.allPadding,
          width: double.infinity,
         decoration: BoxDecoration(
          borderRadius: 10.allBorderRadius,
           color: context.colors.backgroundFieldColor,),
          child: Text("الغرض: ${expenseModel.expensesType}",style: context.textStyles.font14MediumGrayColor,),
        )
      ],
    ),
    );
  }

  Container _buildStatusBox(BuildContext context) {
    return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: expenseModel.status?.chooseColor(context).withValues(alpha: 0.08) ?? context.colors.grayColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child:Text(expenseModel.status?.translate(context) ?? "",style: context.textStyles.font14MediumGrayColor.copyWith(
              color: expenseModel.status?.chooseColor(context) ?? context.colors.grayColor,
            ),),
          );
  }
}