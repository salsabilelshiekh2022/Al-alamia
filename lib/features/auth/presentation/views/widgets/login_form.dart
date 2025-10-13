import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/components/widgets/main_button.dart';
import '../../../../../core/routes/routes.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

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
          20.verticalSpace,
          CustomTextFieldWithLabel(
            label: context.password,
            hintText: context.passwordHint,
            suffixIcon: true,
            prefixWidget: AppAssets.svgsWhiteLockIcon,
          ),
          16.verticalSpace,
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Text(
              context.forgotPassword,
              style: context.textStyles.font16RegularPrimaryColor.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: context.colors.primaryColor,
              ),
            ),
          ),
          32.verticalSpace,
          MainButton(title: context.login, onTap: () {}),
          24.verticalSpace,
          InkWell(
            onTap: () {
              context.pushNamed(Routes.signUpView);
            },
            child: Text(
              context.createNewAccount,
              style: context.textStyles.font16RegularSecondaryColor.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: context.colors.secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
