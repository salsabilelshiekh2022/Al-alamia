import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/widgets/custom_page.dart';
import 'widgets/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: context.login,
      hasActions: true,
      isBack: false,
      body: Column(
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
    );
  }
}
