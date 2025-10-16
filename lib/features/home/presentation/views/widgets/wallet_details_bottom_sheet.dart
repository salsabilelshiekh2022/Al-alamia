import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../generated/app_assets.dart';

class WalletDetailsBottomSheet extends StatelessWidget {
  const WalletDetailsBottomSheet({super.key});

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
              context.dollar,
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
          "1,250.00 ",
          style: context.textStyles.font24BoldSecondaryColor.copyWith(
            fontSize: 28,
          ),
        ),
        32.verticalSizedBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.cashCategory,
              style: context.textStyles.font15MediumGrayColor,
            ),
            Text(
              context.number,
              style: context.textStyles.font15MediumGrayColor,
            ),
            Text(
              context.total,
              style: context.textStyles.font15MediumGrayColor,
            ),
          ],
        ),

        Divider(color: context.colors.strokeColor).verticalPadding(14),

        Column(
          children: List.generate(
            7,
            (index) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$100",
                  style: context.textStyles.font16SemiBoldSecondaryColor,
                ),
                Text(
                  "100",
                  style: context.textStyles.font16SemiBoldSecondaryColor,
                ),
                Text(
                  "\$1,000.00",
                  style: context.textStyles.font16SemiBoldSecondaryColor,
                ),
              ],
            ).onlyPadding(bottomPadding: 20),
          ),
        ),
      ],
    );
  }
}
