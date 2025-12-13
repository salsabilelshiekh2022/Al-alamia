import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/core/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/custom_drop_down.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/components/widgets/main_button.dart';
import '../../../../../generated/app_assets.dart';

class TransactionDetailsSection extends StatelessWidget {
  const TransactionDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.transactionDetails,
          style: context.textStyles.font16SemiBoldSecondaryColor,
        ),
        24.verticalSizedBox,
        CustomTextFieldWithLabel(
          label: context.clientName,
          hintText: context.clientNameHint,
          prefixWidget: AppAssets.svgsUser,
        ),
        20.verticalSizedBox,
        CustomTextFieldWithLabel(
          label: context.phone,
          hintText: context.phone,
          prefixWidget: AppAssets.svgsPhone,
        ),
        20.verticalSizedBox,
        CustomTextFieldWithLabel(
          label: context.commission,
          hintText: context.commission,
          initialValue: "\$2.50 (2.5%)",
          enabled: false,
        ),
        20.verticalSizedBox,
        CustomDropDown(title: context.commissionType, text: "قيمة مضافة"),
        MainButton(
          title: context.confirm,
          onTap: () {
            context.pushReplacementNamed(Routes.transactionReciptView);
          },
        ).verticalPadding(32),
      ],
    );
  }
}
