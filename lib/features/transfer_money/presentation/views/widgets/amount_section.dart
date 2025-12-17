import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../generated/app_assets.dart';

class AmountSection extends StatelessWidget {
  const AmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWithPurpleShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.amount,
            style: context.textStyles.font17SemiBoldSecondaryColor,
          ),
          12.verticalSizedBox,
          CustomTextFieldWithLabel(
            controller: TextEditingController(),
            label: context.amountByChar,
            hintText: context.amountHint,
            isRequired: true,
            prefixWidget: AppAssets.svgsDollarIcon,
            keyboardType: TextInputType.text,
            validator: (val) => Validator.validateAnotherField(val, context),
          ),
        ],
      ),
    );
  }
}