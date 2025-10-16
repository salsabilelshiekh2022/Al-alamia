import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/utils/global_ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/app_assets.dart';
import 'wallet_details_bottom_sheet.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GlobalUiUtils.showBottomSheet(
          context,
          child: WalletDetailsBottomSheet(),
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 19, left: 6, right: 6, bottom: 16),
        decoration: BoxDecoration(
          color: context.colors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: context.colors.strokeColor, width: 1),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(AppAssets.imagesFlag, width: 18, height: 12),
                6.horizontalSpace,
                Text(
                  context.dollar,
                  style: context.textStyles.font13SemiBoldPrimaryColor.copyWith(
                    color: context.colors.grayColor,
                  ),
                ),
              ],
            ),
            20.verticalSizedBox,
            Text(
              "\$2,654.30",
              style: context.textStyles.font16SemiBoldSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
