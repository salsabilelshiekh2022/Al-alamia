import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/core/routes/routes.dart';
import 'package:alalamia/core/utils/global_ui_utils.dart';
import 'package:alalamia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/enums/request_status.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../generated/app_assets.dart';
import '../../../data/models/reset_pass_request_params.dart';
import 'create_new_pass_successfully_dialog.dart';

class CreateNewPasswordBottomSheet extends StatelessWidget {
  const CreateNewPasswordBottomSheet({super.key, required this.phone});
  final String phone;

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
        CreateNewPasswordForm(phone: phone),
      ],
    );
  }
}

class CreateNewPasswordForm extends StatefulWidget {
  const CreateNewPasswordForm({super.key, required this.phone});
  final String phone;

  @override
  State<CreateNewPasswordForm> createState() => _CreateNewPasswordFormState();
}

class _CreateNewPasswordFormState extends State<CreateNewPasswordForm> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  @override
  void initState() {
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
      
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          CustomTextFieldWithLabel(
            controller: passwordController,
            isRequired: true,
            validator: (value) => Validator.validatePassword(value, context),
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
            controller: confirmPasswordController,
            validator: (value) {
              if (value != passwordController.text) {
                return context.passwordNotMatch;
              }
              return null;
            },
            isRequired: true,
            prefixWidget: AppAssets.svgsWhiteLockIcon,
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.authStatus.isSuccess) {
                  context.pushNamedAndRemoveUntil(Routes.loginView);
                  GlobalUiUtils.showCustomDialog(
                    context,
                    child: CreateNewPassSuccessfullyDialog(),
                  );
              }
            },
            builder: (context, state) {
              bool isLoading = state.authStatus == RequestStatus.loading;
              return isLoading ? const CircularProgressIndicator() : MainButton(
                title: context.confirm,
                onTap: () {
                if(formKey.currentState!.validate()){
                  context.read<AuthCubit>().resetPassword(resetPassRequestParams: ResetPassRequestParams(
                  phone: widget.phone,
                  password: passwordController.text,
                  passwordConfirmation: confirmPasswordController.text
                ));
                }else{
                  setState(() {
                    autovalidateMode = AutovalidateMode.always;
                  });
                }
                },
              );
            },
          ).verticalPadding(32),
        ],
      ),
    );
  }
}
