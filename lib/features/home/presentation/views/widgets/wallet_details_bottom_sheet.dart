import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../generated/app_assets.dart';

class WalletDetailsBottomSheet extends StatelessWidget {
  const WalletDetailsBottomSheet({
    super.key,
    required this.currencyName,
    required this.totalBalance,
  });
  final String currencyName;
  final String totalBalance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSvgBuilder(
              path: AppAssets.svgsPurpleDoller,
              width: 22,
              height: 22,
            ),
            8.horizontalSpace,
            Text(
              currencyName,
              style: context.textStyles.font16SemiBoldSecondaryColor,
            ),
          ],
        ),
        24.verticalSizedBox,
        Text(
          context.totalBalance,
          style: context.textStyles.font15MediumGrayColor,
        ),
        14.verticalSizedBox,
        Text(
          totalBalance,
          style: context.textStyles.font24BoldSecondaryColor.copyWith(
            fontSize: 28,
          ),
        ),
        32.verticalSizedBox,
        Row(
          children: [
            Expanded(
              child: Text(
                context.cashCategory,
                textAlign: TextAlign.start,
                style: context.textStyles.font15MediumGrayColor,
              ),
            ),
            Expanded(
              child: Text(
                context.number,
                textAlign: TextAlign.center,

                style: context.textStyles.font15MediumGrayColor,
              ),
            ),
            Expanded(
              child: Text(
                context.total,
                textAlign: TextAlign.end,

                style: context.textStyles.font15MediumGrayColor,
              ),
            ),
          ],
        ),

        Divider(color: context.colors.strokeColor).verticalPadding(14),

        Column(
          children: List.generate(
            7,
            (index) => Row(
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "\$100",
                      textAlign: TextAlign.start,
                      style: context.textStyles.font16SemiBoldSecondaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      "100",
                      textAlign: TextAlign.center,
                      style: context.textStyles.font16SemiBoldSecondaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      "\$1,000.00",
                      textAlign: TextAlign.end,
                      style: context.textStyles.font16SemiBoldSecondaryColor,
                    ),
                  ),
                ),
              ],
            ).onlyPadding(bottomPadding: 20),
          ),
        ),
      ],
    );
  }
}
