import 'package:alalamia/core/helper/app_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalculatorTextField extends StatelessWidget {
  const CalculatorTextField({
    super.key,
    this.controller,
    this.enabled = true,
    this.onChanged,
  });

  final TextEditingController? controller;
  final bool enabled;
  final void Function(String)? onChanged;

  static const double _borderRadius = 12;
  static const double _borderWidth = 1;
  static const EdgeInsets _contentPadding = EdgeInsets.all(4);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: TextField(
        controller: controller,
        style: context.textStyles.font18SemiBoldSecondaryColor,
        keyboardType: TextInputType.number,
        maxLines: 2,
        minLines: 1,
        decoration: _buildInputDecoration(context),
        onChanged: onChanged,
        enabled: enabled,
      ),
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    final border = _buildBorder(context);

    return InputDecoration(
      hintText: "000.00",
      hintStyle: context.textStyles.font15MediumGrayColor,
      contentPadding: _contentPadding,
      fillColor: context.colors.backgroundFieldColor,
      filled: true,
      border: border,
      enabledBorder: border,
      focusedBorder: border,
      disabledBorder: border,
    );
  }

  OutlineInputBorder _buildBorder(BuildContext context) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: context.colors.backgroundFieldColor,
        width: _borderWidth,
      ),
      borderRadius: BorderRadius.circular(_borderRadius.r),
    );
  }
}
