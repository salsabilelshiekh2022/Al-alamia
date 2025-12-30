import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/widgets/app_snack_bar.dart';
import '../../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../../core/components/widgets/main_button.dart';
import '../../../../../../core/enums/request_status.dart';
import '../../../../../../core/helper/app_extention.dart';
// import '../../../../../../core/utils/validator.dart';
import '../../../../../../generated/app_assets.dart';
import '../../../../../auth/data/models/change_pass_request_model.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

final formKey = GlobalKey<FormState>();
AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
late TextEditingController oldPasswordController;
late TextEditingController passwordController;
late TextEditingController confirmPasswordController;

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  @override
  void initState() {
    oldPasswordController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          CustomTextFieldWithLabel(
            controller: oldPasswordController,
            label: context.currentPassword,
            hintText: context.currentPasswordHint,
            prefixWidget: AppAssets.svgsWhiteLockIcon,
            suffixIcon: true,
            // validator: (value) => Validator.(value!.toString()),
          ),
          20.verticalSizedBox,
          CustomTextFieldWithLabel(
            controller: passwordController,
            label: context.newPassword,
            hintText: context.newPasswordHint,
            prefixWidget: AppAssets.svgsWhiteLockIcon,
            suffixIcon: true,
            //  validator: (value) => Validator.passwordValidate(value!.toString()),
          ),
          20.verticalSizedBox,
          CustomTextFieldWithLabel(
            controller: confirmPasswordController,
            label: context.confirmNewPassword,
            hintText: context.confirmPasswordHint,
            prefixWidget: AppAssets.svgsWhiteLockIcon,
            suffixIcon: true,
            validator: (value) {
              if (value!.isEmpty) {
                return context.fieldIsRequired;
              } else if (value != passwordController.text) {
                return context.passwordNotMatch;
              } else {
                return null;
              }
            },
          ),
          40.verticalSizedBox,
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.authStatus.isSuccess) {
                AppSnackBar.showSnackBar(
                  context: context,
                  message: state.message!,
                  state: SnackBarStates.success,
                );
                context.pop();
              }else if (state.authStatus.isError) {
                AppSnackBar.showSnackBar(
                  context: context,
                  message: state.message!,
                  state: SnackBarStates.error,
                );
              }
            },
            child: MainButton(
              title: context.save,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  context.read<AuthCubit>().changePassword(
                    changePassRequestModel: ChangePassRequestModel(
                      oldPassword: oldPasswordController.text,
                      newPassword: passwordController.text,
                      passwordConfirmation: confirmPasswordController.text,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
