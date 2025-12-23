import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/app_extention.dart';

class DeficitAndSurplusWidget extends StatelessWidget {
  const DeficitAndSurplusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildBox(context: context, title: context.inability, value: "12,500 د.ل", color: context.colors.redColor)),
       10.horizontalSpace,
        Expanded(child: _buildBox(context: context, title: context.surplus, value: "12,500 د.ل", color: context.colors.greenColor)),
      ],
    );
  }

  Container _buildBox({required String title, required String value, required BuildContext context, required Color color}) {
    return Container(
            width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      decoration: ShapeDecoration(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    shadows: [
      BoxShadow(
        color: Color(0x14000000),
        blurRadius: 44,
        offset: Offset(0, 0),
        spreadRadius: 0,
      )
    ],
      ),
      child: Row(
        children: [
          Text(
            title,
            style: context.textStyles.font14SemiBoldSecondaryColor.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Text(
            value,
            style: context.textStyles.font16MediumSecondaryColor.copyWith(
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
      );
  }
}