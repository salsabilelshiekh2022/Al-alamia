import 'package:alalamia/core/components/widgets/app_snack_bar.dart';
import 'package:alalamia/core/components/widgets/custom_svg_builder.dart';
import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/core/utils/global_ui_utils.dart';
import 'package:alalamia/features/auth/data/models/verify_code_request_params.dart';
import 'package:alalamia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:alalamia/features/auth/presentation/views/widgets/auth_footer.dart';
import 'package:alalamia/features/auth/presentation/views/widgets/otp_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../generated/app_assets.dart';
import 'create_new_password_bottom_sheet.dart';

class VerficationCodeBottomSheet extends StatefulWidget {
  const VerficationCodeBottomSheet({super.key, required this.phone});

  final String phone;

  @override
  State<VerficationCodeBottomSheet> createState() =>
      _VerficationCodeBottomSheetState();
}

class _VerficationCodeBottomSheetState
    extends State<VerficationCodeBottomSheet> {
  String _otpCode = '';
  bool _isLoading = false;

  static const int _otpLength = 4;

  bool get _isOtpComplete => _otpCode.length == _otpLength;

  void _onOtpChanged(String value) {
    setState(() => _otpCode = value);
  }

  void _onVerifyPressed() {
    if (_isLoading) return;

    if (!_isOtpComplete) {
      AppSnackBar.showSnackBar(
        context: context,
        message: context.fieldIsRequired,
        state: SnackBarStates.warning,
      );
      return;
    }

    context.read<AuthCubit>().verifyCodeOtp(
      verifyCodeRequestParams: VerifyCodeRequestParams(
        phone: widget.phone,
        code: _otpCode,
      ),
    );
  }

  void _onStateChanged(BuildContext context, AuthState state) {
    setState(() => _isLoading = state.authStatus.isLoading);

    if (state.authStatus.isSuccess) {
      GlobalUiUtils.showBottomSheet(
        context,
        child: BlocProvider.value(
          value: getIt<AuthCubit>(),
          child: CreateNewPasswordBottomSheet(phone: widget.phone),
        ),
      );
    } else if (state.authStatus.isError) {
      AppSnackBar.showSnackBar(
        context: context,
        message: state.message ?? '',
        state: SnackBarStates.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: _onStateChanged,
      child: Column(
        children: [
          _buildHeader(context),
          8.verticalSizedBox,
          _buildSubtitle(context),
          24.verticalSizedBox,
          OTPTextField(onChanged: _onOtpChanged),
          _buildResendSection(context),
          _buildVerifyButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
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
          context.verificationCode,
          style: context.textStyles.font18SemiBoldSecondaryColor,
        ),
        const SizedBox(width: 24),
      ],
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      context.weSentCode,
      style: context.textStyles.font15RegularGrayColor,
      textAlign: TextAlign.center,
    ).horizontalPadding(50);
  }

  Widget _buildResendSection(BuildContext context) {
    return AuthFooterWidget(
      clickable: context.preseHere,
      notClickable: context.notReceivedMessage,
      onTap: () {
        // User will integrate resend OTP functionality
      },
      hasUnderLine: false,
    ).verticalPadding(32);
  }

  Widget _buildVerifyButton(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : MainButton(
            title: context.next,
            onTap: _onVerifyPressed,
          ).onlyPadding(bottomPadding: 30);
  }
}
