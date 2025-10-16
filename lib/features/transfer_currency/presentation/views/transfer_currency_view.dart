import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/components/widgets/custom_svg_builder.dart';
import 'package:alalamia/core/components/widgets/custom_text_field_with_label.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/widgets/custom_drop_down.dart';
import 'widgets/total_section.dart';
import 'widgets/transaction_details_section.dart';

class TransferCurrencyView extends StatelessWidget {
  const TransferCurrencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: context.currencyTransfer,
      isBack: true,
      hasActions: false,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.currencyExchange,
            style: context.textStyles.font16SemiBoldSecondaryColor,
          ),
          24.verticalSizedBox,

          CustomDropDown(title: context.fromCurrency, text: context.dollar),
          14.verticalSizedBox,
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17.r),
              color: context.colors.primaryColor,
            ),
            child: CustomSvgBuilder(
              path: AppAssets.svgsTransfarIcon,
              width: 18,
              height: 18,
              fit: BoxFit.scaleDown,
            ),
          ).center(),
          CustomDropDown(title: context.toCurrency, text: context.dollar),
          20.verticalSpace,
          CustomTextFieldWithLabel(
            controller: TextEditingController(text: '100.00'),
            label: context.amount,
            hintText: context.amountHint,
            textAlign: TextAlign.center,
          ),
          20.verticalSizedBox,
          TotalSection(),
          32.verticalSizedBox,
          TransactionDetailsSection(),
        ],
      ),
    );
  }
}
