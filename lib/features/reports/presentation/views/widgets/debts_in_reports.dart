import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/app_extention.dart';
import '../../../../../core/helper/number_extentions.dart';

class DebtsInReports extends StatelessWidget {
  const DebtsInReports({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadows: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 44,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
           context.dailyDebt,
            style: context.textStyles.font16MediumSecondaryColor,
          ),
          14.verticalSizedBox,
          _buildGrayBox(
            context: context,
            title: context.internalDebt,
            value: "12,500 د.ل",
          ),
            10.verticalSizedBox,
          _buildGrayBox(
            context: context,
            title: context.externalDebt,
            value: "12,500 د.ل",
          ),
        ],
      ),
    );
  }

  Widget _buildGrayBox({required BuildContext context, required String title, required String value}) {
    return Container(
          width: double.infinity,
          padding: 12.allPadding,
          decoration: BoxDecoration(
            color: context.colors.backgroundFieldColor,
            border: Border.all(
              color: context.colors.strokeColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: context.textStyles.font14MediumPrimaryColor.copyWith(
                      color: context.colors.grayColor,
                    ),
                  ),
                  Text(
                    value,
                    style: context.textStyles.font16MediumSecondaryColor
                       
                  ),
                ],
              ),
            ],
          ),
        );
  }
}
