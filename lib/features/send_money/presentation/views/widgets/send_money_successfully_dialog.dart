import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/app_assets.dart';

class SendMoneySuccessfullyDialog extends StatelessWidget {
  const SendMoneySuccessfullyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppAssets.imagesCheck, width: 48, height: 48),
        20.verticalSizedBox,
        Text(
          context.moneySentSuccessfully,
          style: context.textStyles.font18SemiBoldSecondaryColor,
        ),
        8.verticalSizedBox,
        Text(
          context.canSeeDetails,
          style: context.textStyles.font15RegularGrayColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
