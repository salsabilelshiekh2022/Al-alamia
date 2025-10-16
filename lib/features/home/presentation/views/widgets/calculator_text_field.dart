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

            fillColor: Color(0xffEFEFEF),
            filled: true,
            border: _buildBorder(),
            enabledBorder: _buildBorder(),
            focusedBorder: _buildBorder(),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffEFEFEF)),
      borderRadius: BorderRadius.circular(12.r),
    );
  }
}
