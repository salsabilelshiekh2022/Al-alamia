import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:flutter/material.dart';

class CreateNewPassSuccessfullyDialog extends StatelessWidget {
  const CreateNewPassSuccessfullyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppAssets.imagesCheck, width: 48, height: 48),
        20.verticalSizedBox,
        Text(
          context.passwordCreatedSuccessfully,
          style: context.textStyles.font18SemiBoldSecondaryColor,
        ),
        8.verticalSizedBox,
        Text(
          context.rememberNotShare,
          style: context.textStyles.font15RegularGrayColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
