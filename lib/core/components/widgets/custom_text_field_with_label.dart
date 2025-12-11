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
    this.prefixWidget,
    this.textAlign,
    this.enabled,
    this.initialValue,
    this.maxLines,
    this.isRequired = false,
    this.isReadOnly,
    this.onTap,
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
  final String? prefixWidget;
  final TextAlign? textAlign;
  final bool? enabled;
  final bool? isReadOnly;
  final String? initialValue;
  final int? maxLines;
  final bool isRequired;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: widgetHorizontalPadding ?? 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label, style: context.textStyles.font16MediumSecondaryColor),
              if (isRequired)
                Text(
                  '  *',
                  style: context.textStyles.font16MediumSecondaryColor.copyWith(
                    color: Colors.red,
                  ),
                ),
            ],
          ),
          10.verticalSpace,
          Padding(
            padding: REdgeInsets.symmetric(
              horizontal: textFiledHorizontalPadding ?? 0,
            ),
            child: CustomTextField(
              onTap: onTap,
              textAlign: textAlign,
              initialValue: initialValue,
              maxLines: maxLines ?? 1,
              prefixWidget: prefixWidget,
              inputFormatters: inputFormatters,
              controller: controller,
              focusNode: focusNode,
              isObscured: isObscured ?? false,
              keyboardType: keyboardType,
              suffixWidget: suffixWidget,
              suffixIcon: suffixIcon,
              hintText: hintText,
              isReadOnly: isReadOnly,
              enabled: enabled ?? true,
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
