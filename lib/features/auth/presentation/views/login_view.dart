import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/widgets/custom_app_bar.dart';
import 'widgets/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppAssets.imagesBackground,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          CustomAppBar(
            title: context.login,
            hasActions: true,
          ).onlyPadding(bottomPadding: 24),
          Container(
            margin: EdgeInsets.only(top: 130.h),
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: context.colors.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                Text(
                  context.alalamia,
                  style: context.textStyles.font20MediumSecondaryColor,
                ),
                20.verticalSpace,
                Image.asset(
                  AppAssets.imagesLogo,
                  width: 230.w,
                  height: 64.h,
                  fit: BoxFit.cover,
                ),
                28.verticalSpace,
                LoginForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
