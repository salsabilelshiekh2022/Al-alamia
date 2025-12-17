import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/app_extention.dart';
import '../../../../../core/helper/number_extentions.dart';
import '../../../../transactions/presentation/views/widgets/transactions_details/card_with_shadow.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWithShadow(borderRadius: 12,padding: 14,
    child: Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: context.colors.greenColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child:Text("مقبولة",style: context.textStyles.font14MediumGrayColor.copyWith(
                color: context.colors.greenColor
              ),),
            ),
            Spacer(),
            Text("15 يناير 2025",style: context.textStyles.font14MediumGrayColor,),
          ],
        ),
        16.verticalSizedBox,
        Row(
          children: [
            Text("أحمد محمد ",style: context.textStyles.font15SemiBoldSecondaryColor,),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("usd",style: context.textStyles.font13SemiBoldPrimaryColor.copyWith(color: context.colors.grayColor, fontWeight: FontWeight.w500),),
                Text("1,250",style: context.textStyles.font16SemiBoldSecondaryColor,),
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
          child: Text("الغرض: مصاريف تعليمية",style: context.textStyles.font14MediumGrayColor,),
        )
      ],
    ),
    );
  }
}