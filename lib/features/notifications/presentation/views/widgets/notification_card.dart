import 'package:alalamia/core/helper/app_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/card_with_gray_border.dart';
import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../core/enums/transactions_status_enum.dart';
import '../../../../../generated/app_assets.dart';
import '../../../../transactions/presentation/views/widgets/transaction_status_box.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWithGrayBorder(child: Row(children: [
      CustomSvgBuilder(path: AppAssets.svgsPurpleStarIcon, width: 30, height: 30, fit: BoxFit.scaleDown),
      12.horizontalSpace,
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("تحديث أمني", style: context.textStyles.font14SemiBoldSecondaryColor,),
            5.verticalSpace,
            Text("تم تحديث إعدادات أمان حسابك بنجاح باستخدام المصادقة الثنائية",
            maxLines: 2,
             style: context.textStyles.font14RegularGrayColor.copyWith(fontSize: 12),),
          ],
        ),
      ),
      35.verticalSpace  ,
      Column(
        children: [
          TransactionStatusBox(status: TransactionsStatusEnum.pending),
         22.verticalSpace,
          Text("منذ ساعتين", style: context.textStyles.font14MediumGrayColor.copyWith(
            fontSize: 13
          ),)
        ],
      )

    ]));
  }
}
