import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/core/routes/routes.dart';
import 'package:alalamia/core/utils/global_ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../generated/app_assets.dart';
import 'create_new_pass_successfully_dialog.dart';

class CreateNewPasswordBottomSheet extends StatelessWidget {
  const CreateNewPasswordBottomSheet({super.key});

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
              context.createNewPassword,
              style: context.textStyles.font18SemiBoldSecondaryColor,
            ),
            SizedBox(width: 24),
          ],
        ),
        8.verticalSizedBox,
        Text(
          context.enterNewPasswordWithoutSharing,
          style: context.textStyles.font15RegularGrayColor,
          textAlign: TextAlign.center,
        ).horizontalPadding(60),
        24.verticalSizedBox,
        CreateNewPasswordForm(),
      ],
    );
  }
}

class CreateNewPasswordForm extends StatelessWidget {
  const CreateNewPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomTextFieldWithLabel(
            label: context.newPassword,
            hintText: context.newPasswordHint,
            suffixIcon: true,
            prefixWidget: AppAssets.svgsWhiteLockIcon,
          ),
          20.verticalSpace,
          CustomTextFieldWithLabel(
            label: context.confirmNewPassword,
            hintText: context.confirmNewPasswordHint,
            suffixIcon: true,
            prefixWidget: AppAssets.svgsWhiteLockIcon,
          ),
          MainButton(
            title: context.confirm,
            onTap: () {
              context.pushNamedAndRemoveUntil(Routes.loginView);
              GlobalUiUtils.showCustomDialog(
                context,
                child: CreateNewPassSuccessfullyDialog(),
              );
            },
          ).verticalPadding(32),
        ],
      ),
    );
  }
}
