import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/auth/presentation/views/widgets/auth_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../generated/app_assets.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomTextFieldWithLabel(
            label: context.userName,
            hintText: context.userNameHint,
            prefixWidget: AppAssets.svgsUser,
          ),
          20.verticalSpace,
          CustomTextFieldWithLabel(
            label: context.phone,
            hintText: context.phoneHint,
            prefixWidget: AppAssets.svgsPhone,
          ),
          20.verticalSpace,
          CustomTextFieldWithLabel(
            label: context.email,
            hintText: context.emailHint,
            prefixWidget: AppAssets.svgsMail,
          ),
          20.verticalSpace,
          CustomTextFieldWithLabel(
            label: context.password,
            hintText: context.passwordHint,
            suffixIcon: true,
            prefixWidget: AppAssets.svgsWhiteLockIcon,
          ),
          20.verticalSpace,
          CustomTextFieldWithLabel(
            label: context.confirmPassword,
            hintText: context.confirmPasswordHint,
            suffixIcon: true,
            prefixWidget: AppAssets.svgsWhiteLockIcon,
          ),
          32.verticalSpace,
          MainButton(title: context.signUp, onTap: () {}),
          24.verticalSpace,
          AuthFooterWidget(
            clickable: context.login,
            notClickable: context.alreadyHaveAccount,
            onTap: () {
              context.pushNamedAndRemoveUntil(Routes.loginView);
            },
          ),
        ],
      ),
    );
  }
}
