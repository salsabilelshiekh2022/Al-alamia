import 'package:alalamia/core/helper/app_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPTextField extends StatefulWidget {
  const OTPTextField({super.key, this.onChanged});

  final void Function(String)? onChanged;
  @override
  State<OTPTextField> createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        appContext: context,
        length: 4,
        keyboardType: TextInputType.number,
        textStyle: context.textStyles.font18SemiBoldSecondaryColor.copyWith(
          fontWeight: FontWeight.w500,
        ),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(12.r),
          fieldHeight: 61.h,
          fieldWidth: 75.w,
          borderWidth: 0.2,
          activeFillColor: context.colors.backgroundFieldColor,
          activeColor: context.colors.strokeColor,
          inactiveFillColor: context.colors.backgroundFieldColor,
          inactiveColor: context.colors.strokeColor,
          selectedFillColor: context.colors.backgroundFieldColor,
          selectedColor: context.colors.primaryColor,
          selectedBorderWidth: 1,
          errorBorderWidth: 1,
          activeBorderWidth: 1,
          disabledBorderWidth: 1,
          inactiveBorderWidth: 1,
        ),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        animationType: AnimationType.fade,
        cursorColor: context.colors.primaryColor,
        cursorWidth: 0.7,
        onChanged: widget.onChanged,
        beforeTextPaste: (text) {
          return RegExp(r'^[0-9]+$').hasMatch(text ?? '');
        },
      ),
    );
  }
}
