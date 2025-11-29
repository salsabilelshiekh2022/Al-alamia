import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/components/widgets/custom_text_field_with_label.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/widgets/main_button.dart';
import '../../../../generated/app_assets.dart';

class PaymentDebtView extends StatelessWidget {
  const PaymentDebtView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: context.paymentDebt,
      hasActions: false,
      isBack: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      body: Column(
        children: [
          CustomTextFieldWithLabel(
            label: context.currency,
            hintText: context.currenyHint,
            prefixWidget: AppAssets.svgsCoinsIcon,
            isRequired: true,
            isReadOnly: true,
          ),
          20.verticalSizedBox,
          CustomTextFieldWithLabel(
            label: context.amount,
            hintText: context.enterAmountYouWantToPay,
            isRequired: true,
            keyboardType: TextInputType.number,
          ),
          40.verticalSizedBox,
          MainButton(
            title: context.send,
            onTap: () {
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
