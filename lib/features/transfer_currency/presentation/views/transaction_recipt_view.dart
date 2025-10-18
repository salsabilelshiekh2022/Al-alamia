import 'package:alalamia/core/components/widgets/custom_svg_builder.dart';
import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:flutter/material.dart';

import 'widgets/transaction_recipt_details.dart';

class TransactionReciptView extends StatelessWidget {
  const TransactionReciptView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            103.verticalSizedBox,
            Image.asset(AppAssets.imagesSuccess, width: 96, height: 96),
            8.verticalSizedBox,
            Text(
              context.successTransaction,
              style: context.textStyles.font16SemiBoldSecondaryColor,
            ),
            8.verticalSizedBox,
            Text(
              " EGP 4,865.00 ",
              style: context.textStyles.font24BoldSecondaryColor.copyWith(
                color: context.colors.greenColor,
              ),
            ),
            32.verticalSizedBox,
            TransactionReciptDetails(),
            24.verticalSizedBox,
            Row(
              children: [
                Container(
                  padding: 13.allPadding,

                  decoration: BoxDecoration(
                    color: context.colors.primaryColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CustomSvgBuilder(
                    path: AppAssets.svgsShareIcon,
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                10.horizontalSizedBox,
                Expanded(
                  child: MainButton(
                    title: context.back,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ],
            ).horizontalPadding(16),
            30.verticalSizedBox,
          ],
        ),
      ),
    );
  }
}
