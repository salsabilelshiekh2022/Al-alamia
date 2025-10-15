
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../../generated/app_assets.dart';
import 'card_with_shadow.dart';
import 'total_section.dart';

class TransactionInfoCard extends StatelessWidget {
  const TransactionInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  CardWithShadow(child: Column(
      children: [
        Row(
          children: [
            CustomSvgBuilder(path: AppAssets.svgsTransactionInfoIcon, width: 24, height: 24, fit: BoxFit.scaleDown,),
            10.horizontalSpace,
            Text(context.transactionInfo, style: context.textStyles.font16MediumSecondaryColor,),
          ],
        ),
        17.verticalSizedBox,
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(context.transactionCode, style: context.textStyles.font16MediumSecondaryColor.copyWith(
            color: context.colors.grayColor
          ),),
           Text("#12345678", style: context.textStyles.font16MediumSecondaryColor),
        ],
       ),
       14.verticalSizedBox,
              Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(context.commission, style: context.textStyles.font16MediumSecondaryColor.copyWith(
            color: context.colors.grayColor
          ),),
           Text("\$0.00", style: context.textStyles.font16MediumSecondaryColor),
        ],
       ),
       14.verticalSizedBox,
              Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(context.exchangeRate, style: context.textStyles.font16MediumSecondaryColor.copyWith(
            color: context.colors.grayColor
          ),),
           Text("\$0.00", style: context.textStyles.font16MediumSecondaryColor),
        ],
       ),
       Divider(
        color: context.colors.strokeColor,
       ).verticalPadding(14),
       TotalSection(),
      ],
    ));
  }
}
