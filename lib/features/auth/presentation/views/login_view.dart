import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../core/components/widgets/custom_page.dart';
import '../cubit/auth_cubit.dart';
import 'widgets/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: context.watch<AuthCubit>().state.authStatus.isLoading,
      child: CustomPage(
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
      ),
    );
  }
}
