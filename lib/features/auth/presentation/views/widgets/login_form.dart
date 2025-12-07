import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/utils/global_ui_utils.dart';
import 'package:alalamia/core/utils/validator.dart';
import 'package:alalamia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/app_snack_bar.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/components/widgets/main_button.dart';
import '../../../../../core/routes/routes.dart';
import '../../../data/models/login_request_params.dart';
import 'forget_password_bottom_sheet.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();

    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.authStatus.isSuccess) {
          context.pushNamedAndRemoveUntil(Routes.mainNavigationView);
        } else if (state.authStatus.isError) {
          AppSnackBar.showSnackBar(
            context: context,
            message: state.errorMessage!,
            state: SnackBarStates.error,
          );
        }
      },
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextFieldWithLabel(
              controller: phoneController,
              label: context.phone,
              hintText: context.phoneHint,
              prefixWidget: AppAssets.svgsPhone,
              validator: (value) => Validator.validatePhone(value, context),
            ),
            20.verticalSpace,
            CustomTextFieldWithLabel(
              controller: passwordController,
              label: context.password,
              hintText: context.passwordHint,
              suffixIcon: true,
              prefixWidget: AppAssets.svgsWhiteLockIcon,
              validator: (value) => Validator.validatePassword(value, context),
            ),
            16.verticalSpace,
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: InkWell(
                onTap: () => GlobalUiUtils.showBottomSheet(
                  context,
                  child: ForgetPasswordBottomsheet(),
                ),
                child: Text(
                  context.forgotPassword,
                  style: context.textStyles.font16RegularPrimaryColor.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: context.colors.primaryColor,
                  ),
                ),
              ),
            ),
            32.verticalSpace,
            MainButton(
              title: context.login,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  context.read<AuthCubit>().login(
                    loginRequestParams: LoginRequestParams(
                      phone: phoneController.text,
                      password: passwordController.text,
                    ),
                  );
                }
                // context.pushNamedAndRemoveUntil(Routes.mainNavigationView);
              },
            ),
            24.verticalSpace,
            InkWell(
              onTap: () {
                context.pushNamed(Routes.registerationMethodView);
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
      ),
    );
  }
}
