import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../generated/app_assets.dart';

class BeneficiaryDataCard extends StatelessWidget {
  const BeneficiaryDataCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWithPurpleShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.beneficiary,
            style: context.textStyles.font16SemiBoldSecondaryColor,
          ),
          12.verticalSizedBox,

          CustomTextFieldWithLabel(
            label: context.name,
            hintText: context.fullNameHint,
            prefixWidget: AppAssets.svgsUser,
            isRequired: true,
          ),
          16.verticalSizedBox,
          CustomTextFieldWithLabel(
            label: context.phone,
            hintText: context.phoneHint,
            prefixWidget: AppAssets.svgsPhone,
            keyboardType: TextInputType.phone,
            isRequired: true,
          ),
          16.verticalSizedBox,
          CustomTextFieldWithLabel(
            label: context.additionalNumber,
            hintText: context.additionalNumberHint,
            prefixWidget: AppAssets.svgsAdditionalPhoneIcon,
            keyboardType: TextInputType.phone,
          ),
          16.verticalSizedBox,
          CustomTextFieldWithLabel(
            label: context.address,
            hintText: context.addressHint,
            prefixWidget: AppAssets.svgsMapIcon,
            isRequired: false,
          ),
        ],
      ),
    );
  }
}
