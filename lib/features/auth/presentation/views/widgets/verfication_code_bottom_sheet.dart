import 'package:alalamia/core/components/widgets/custom_svg_builder.dart';
import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/core/utils/global_ui_utils.dart';
import 'package:alalamia/features/auth/presentation/views/widgets/auth_footer.dart';
import 'package:alalamia/features/auth/presentation/views/widgets/otp_text_field.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/app_assets.dart';
import 'create_new_password_bottom_sheet.dart';

class VerficationCodeBottomSheet extends StatelessWidget {
  const VerficationCodeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => context.pop(),
              child: CustomSvgBuilder(
                path: AppAssets.svgsArrowBackIcon,
                width: 24,
                height: 24,
              ),
            ),
            Text(
              context.verificationCode,
              style: context.textStyles.font18SemiBoldSecondaryColor,
            ),
            SizedBox(width: 24),
          ],
        ),
        8.verticalSizedBox,
        Text(
          context.weSentCode,
          style: context.textStyles.font15RegularGrayColor,
          textAlign: TextAlign.center,
        ).horizontalPadding(50),
        24.verticalSizedBox,
        OTPTextField(),

        AuthFooterWidget(
          clickable: context.preseHere,
          notClickable: context.notReceivedMessage,
          onTap: () {},
          hasUnderLine: false,
        ).verticalPadding(32),
        MainButton(
          title: context.next,
          onTap: () => GlobalUiUtils.showBottomSheet(
            context,
            child: CreateNewPasswordBottomSheet(),
          ),
        ).onlyPadding(bottomPadding: 30),
      ],
    );
  }
}
