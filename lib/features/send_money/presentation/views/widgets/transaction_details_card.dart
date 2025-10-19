import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../generated/app_assets.dart';

class TransactionDetailsCard extends StatelessWidget {
  const TransactionDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWithPurpleShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.transactionDetails,
            style: context.textStyles.font16SemiBoldSecondaryColor,
          ),
          12.verticalSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomTextFieldWithLabel(
                  label: context.amount,
                  hintText: context.amountHint,
                  prefixWidget: AppAssets.svgsDollarIcon,
                ),
              ),
              14.horizontalSizedBox,
              Expanded(
                child: CustomTextFieldWithLabel(
                  label: context.currency,
                  hintText: context.currenyHint,
                  prefixWidget: AppAssets.svgsDollarIcon,
                ),
              ),
            ],
          ),
          16.verticalSizedBox,
          CustomTextFieldWithLabel(
            label: context.amountByChar,
            hintText: context.amountHint,
            prefixWidget: AppAssets.svgsDollarIcon,
          ),
          16.verticalSizedBox,
          CustomTextFieldWithLabel(
            label: context.resource,
            hintText: context.recourseHint,
            prefixWidget: AppAssets.svgsBank,
          ),
          16.verticalSizedBox,
          CustomTextFieldWithLabel(
            label: context.destination,
            hintText: context.distinctionHint,
            prefixWidget: AppAssets.svgsBank,
          ),
          16.verticalSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomTextFieldWithLabel(
                  label: context.commission,
                  initialValue: "\$20",
                  hintText: "\$20",
                  enabled: false,
                  prefixWidget: AppAssets.svgsCoinsIcon,
                ),
              ),
              14.horizontalSizedBox,
              Expanded(
                child: CustomTextFieldWithLabel(
                  label: context.commissionType,
                  hintText: context.commissionType,
                  prefixWidget: AppAssets.svgsCoinsIcon,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
