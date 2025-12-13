import 'package:alalamia/core/components/widgets/custom_svg_builder.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.focusNode,
    this.isObscured,
    this.keyboardType,
    this.validator,
    this.controller,
    this.inputFormatters,
    this.enabled,
    this.onTap,
    this.maxLines = 1,
    this.isReadOnly,
    this.suffixWidget,
    this.suffixIcon,
    this.prefixWidget,
    this.textAlign,
    this.initialValue,
    this.onChanged,
    this.textStyle,
  });

  final String hintText;

  final FocusNode? focusNode;
  final bool? isObscured;
  final TextInputType? keyboardType;
  final Function(String?)? validator;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final bool? isReadOnly;
  final void Function()? onTap;
  final int maxLines;
  final Widget? suffixWidget;
  final String? prefixWidget;
  final String? initialValue;
  final bool? suffixIcon;
  final TextAlign? textAlign;
  final void Function(String)? onChanged;
  final TextStyle? textStyle;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      textAlign: widget.textAlign ?? TextAlign.start,
      maxLines: widget.maxLines,
      enabled: widget.enabled,
      readOnly: widget.isReadOnly ?? false,
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: _showPassword,
      keyboardType: widget.keyboardType,
      cursorColor: context.colors.primaryColor,
      cursorErrorColor: context.colors.primaryColor,
      style: widget.textStyle ?? context.textStyles.font14MediumSecondaryColor,
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: context.colors.backgroundFieldColor,
        filled: true,
        hintText: widget.hintText,
        hintStyle: context.textStyles.font14MediumGrayColor,

        prefixIcon: widget.prefixWidget == null
            ? null
            : CustomSvgBuilder(
                path: widget.prefixWidget!,
                width: 20,
                height: 20,
                fit: BoxFit.scaleDown,
              ),
        suffixIcon: widget.suffixIcon == true && widget.suffixWidget == null
            ? IconButton(
                padding: const EdgeInsets.all(0),
                icon: _showPassword
                    ? CustomSvgBuilder(
                        path: AppAssets.svgsEyeIcon,
                        width: 20,
                        height: 20,
                        fit: BoxFit.scaleDown,
                      )
                    : CustomSvgBuilder(
                        path: AppAssets.svgsEyeClosedIcon,
                        width: 20,
                        height: 20,
                        fit: BoxFit.scaleDown,
                      ),
                onPressed: () => setState(() => _showPassword = !_showPassword),
              )
            : widget.suffixWidget,
        enabledBorder: _defaultBorder(context.colors),
        disabledBorder: _defaultBorder(context.colors),
        focusedBorder: _focusedBorder(context.colors),
        errorBorder: _errorBorder(context.colors),
        focusedErrorBorder: _focusedBorder(context.colors),
      ),
      onChanged: widget.onChanged,
      textAlignVertical: TextAlignVertical.center,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      onTap: widget.onTap,
    );
  }

  OutlineInputBorder _defaultBorder(AppColors appColors) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(14.0.r),
    borderSide: BorderSide(color: appColors.strokeColor, width: 1),
  );

  OutlineInputBorder _focusedBorder(AppColors appColors) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(14.0.r),
    borderSide: BorderSide(
      color: appColors.primaryColor.withValues(alpha: 0.5),
      width: 1,
    ),
  );

  OutlineInputBorder _errorBorder(AppColors appColors) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(14.0.r),
    borderSide: BorderSide(color: appColors.redColor, width: 1),
  );
}
