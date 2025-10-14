import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../../core/components/widgets/main_button.dart';
import '../../../../../../generated/app_assets.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomTextFieldWithLabel(
            label: context.currentPassword,
            hintText: context.currentPasswordHint,
            prefixWidget: AppAssets.svgsWhiteLockIcon,
            suffixIcon: true,
          ),
          20.verticalSizedBox,
          CustomTextFieldWithLabel(
            label: context.newPassword,
            hintText: context.newPasswordHint,
            prefixWidget: AppAssets.svgsWhiteLockIcon,
            suffixIcon: true,
          ),
          20.verticalSizedBox,
          CustomTextFieldWithLabel(
            label: context.confirmNewPassword,
            hintText: context.confirmPasswordHint,
            prefixWidget: AppAssets.svgsWhiteLockIcon,
            suffixIcon: true,
          ),
          40.verticalSizedBox,
          MainButton(title: context.save, onTap: (){
            context.pop();
          }),
        ],
      ),
    );
  }
}
