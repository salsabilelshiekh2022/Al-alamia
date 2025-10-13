import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/auth/presentation/views/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/app_assets.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: context.createNewAccount,
      hasActions: true,
      isBack: true,
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
          SignUpForm(),
        ],
      ),
    );
  }
}
