import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/core/utils/global_ui_utils.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../generated/app_assets.dart';
import 'verfication_code_bottom_sheet.dart';

class ForgetPasswordBottomsheet extends StatelessWidget {
  const ForgetPasswordBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.forgetPasswordWithoutQuestion,
          style: context.textStyles.font18SemiBoldSecondaryColor,
        ),
        8.verticalSizedBox,
        Text(
          context.enterPhoneToSendCode,
          style: context.textStyles.font15RegularGrayColor,
          textAlign: TextAlign.center,
        ).horizontalPadding(63),
        24.verticalSizedBox,
        ForgetPassWordForm(),
      ],
    );
  }
}

class ForgetPassWordForm extends StatelessWidget {
  const ForgetPassWordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomTextFieldWithLabel(
            label: context.phone,
            hintText: context.phoneHint,
            prefixWidget: AppAssets.svgsPhone,
          ),
          MainButton(
            title: context.next,
            onTap: () => GlobalUiUtils.showBottomSheet(
              context,
              child: VerficationCodeBottomSheet(),
            ),
          ).verticalPadding(32),
        ],
      ),
    );
  }
}
