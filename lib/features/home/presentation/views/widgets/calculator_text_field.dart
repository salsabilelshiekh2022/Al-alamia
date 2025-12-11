import 'package:alalamia/core/helper/app_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalculatorTextField extends StatelessWidget {
  const CalculatorTextField({
    super.key,
    this.controller,
    this.enabled,
    this.onChanged,
  });

  final TextEditingController? controller;
  final bool? enabled;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: SizedBox(
        child: TextField(
          controller: controller,
          style: context.textStyles.font18SemiBoldSecondaryColor,
          keyboardType: TextInputType.number,
          maxLines: 2,
          minLines: 1,
          decoration: InputDecoration(
            hint: Text(
              "000.00",
              style: context.textStyles.font15MediumGrayColor,
            ),
            contentPadding: EdgeInsets.all(4),
            fillColor: context.colors.backgroundFieldColor,
            filled: true,

            enabled: enabled ?? true,
            border: _buildBorder(context),
            enabledBorder: _buildBorder(context),
            focusedBorder: _buildBorder(context),
            disabledBorder: _buildBorder(context),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder(BuildContext context) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: context.colors.backgroundFieldColor,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(12.r),
    );
  }
}
