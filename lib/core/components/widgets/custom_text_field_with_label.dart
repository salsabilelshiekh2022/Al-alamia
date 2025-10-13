import 'package:alalamia/core/helper/app_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text_field.dart';

class CustomTextFieldWithLabel extends StatelessWidget {
  const CustomTextFieldWithLabel({
    super.key,
    required this.label,
    required this.hintText,

    this.focusNode,
    this.isObscured,
    this.keyboardType,
    this.validator,
    this.controller,
    this.inputFormatters,
    this.widgetHorizontalPadding,
    this.textFiledHorizontalPadding,
    this.suffixWidget,
    this.suffixIcon,
  });

  final String label;
  final String hintText;
  final Widget? suffixWidget;
  final bool? suffixIcon;
  final FocusNode? focusNode;
  final bool? isObscured;
  final TextInputType? keyboardType;
  final Function(String?)? validator;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final double? widgetHorizontalPadding;
  final double? textFiledHorizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: widgetHorizontalPadding ?? 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: context.textStyles.font16SemiBoldSecondaryColor),
          10.verticalSpace,
          Padding(
            padding: REdgeInsets.symmetric(
              horizontal: textFiledHorizontalPadding ?? 0,
            ),
            child: CustomTextField(
              inputFormatters: inputFormatters,
              controller: controller,
              focusNode: focusNode,
              isObscured: isObscured ?? false,
              keyboardType: keyboardType,
              suffixWidget: suffixWidget,
              suffixIcon: suffixIcon,
              hintText: hintText,

              validator: (value) {
                if (validator != null) {
                  return validator!(value);
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
