import 'package:alalamia/core/helper/app_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalculatorTextField extends StatelessWidget {
  const CalculatorTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 46,
        child: TextField(
          style: context.textStyles.font18SemiBoldSecondaryColor,
          decoration: InputDecoration(
            hint: Text(
              "000.00",
              style: context.textStyles.font15MediumGrayColor,
            ),

            fillColor: context.colors.backgroundFieldColor,
            filled: true,
            border: _buildBorder(context),
            enabledBorder: _buildBorder(context),
            focusedBorder: _buildBorder(context),
          ),
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
