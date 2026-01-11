import 'package:alalamia/core/components/widgets/app_snack_bar.dart';
import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/core/utils/global_ui_utils.dart';
import 'package:alalamia/features/auth/data/models/send_code_request_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/enums/request_status.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../generated/app_assets.dart';
import '../../cubit/auth_cubit.dart';
import 'verfication_code_bottom_sheet.dart';

class ForgetPasswordBottomsheet extends StatelessWidget {
  const ForgetPasswordBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.forgetPasswordWithoutQuestion,
          style: context.textStyles.font18SemiBoldSecondaryColor,
        ),
        8.verticalSizedBox,
        Text(
          context.enterPhoneToSendCode,
          style: context.textStyles.font15RegularGrayColor,
          textAlign: TextAlign.center,
        ).horizontalPadding(63),
        24.verticalSizedBox,
        ForgetPassWordForm(),
      ],
    );
  }
}

class ForgetPassWordForm extends StatefulWidget {
  const ForgetPassWordForm({super.key});

  @override
  State<ForgetPassWordForm> createState() => _ForgetPassWordFormState();
}

late TextEditingController phoneController;
final formKey = GlobalKey<FormState>();
AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

class _ForgetPassWordFormState extends State<ForgetPassWordForm> {
  @override
  void initState() {
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
       
      if(state.authStatus.isSuccess) {
            GlobalUiUtils.showBottomSheet(
              context,
              child: VerficationCodeBottomSheet(
                phone: phoneController.text,
              ),
            );
      }else if(state.authStatus.isError) {
        AppSnackBar.showSnackBar(context: context, message: state.message!, state: SnackBarStates.error);
      }
      
      },
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: [
            CustomTextFieldWithLabel(
              controller: phoneController,
              label: context.phone,
              hintText: context.phoneHint,
              keyboardType: TextInputType.phone,
              prefixWidget: AppAssets.svgsPhone,
              validator: (value) => Validator.validatePhone(value, context),
            ),
            MainButton(
              title: context.next,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  context.read<AuthCubit>().sendCodeOtp(
                    sendCodeRequestParams: SendCodeRequestParams(
                      phone: phoneController.text,
                    ),
                  );
                } else {
                  autovalidateMode = AutovalidateMode.always;
                }
              },
            ).verticalPadding(32),
          ],
        ),
      ),
    );
  }
}
