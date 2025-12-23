import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/app_extention.dart';
import '../../../../../core/helper/number_extentions.dart';
import '../../../../../core/helper/translation_extensions.dart';
import '../../../../../core/helper/widget_extentions.dart';

class ExpensesInReports extends StatefulWidget {
  const ExpensesInReports({super.key});

  @override
  State<ExpensesInReports> createState() => _ExpensesInReportsState();
}

class _ExpensesInReportsState extends State<ExpensesInReports> {
  bool openDrowpdown = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          openDrowpdown = !openDrowpdown;
        });
      },
      child: Container(
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
        child: Column(
          children: [
            Row(
                  children: [
            Text(context.expenses, style: context.textStyles.font16MediumSecondaryColor,),
            Spacer(),
            Text("45,000 د.ل", style: context.textStyles.font16SemiBoldSecondaryColor.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colors.grayColor,
            ),
            ),
            6.horizontalSizedBox,
            Icon(openDrowpdown ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down_rounded, size: 24.w, color: context.colors.grayColor,),
                  ],
            ),
          openDrowpdown ?  _buildBalanceData(context) : SizedBox(),

          ],
        ),
      ),
    ).onlyPadding(bottomPadding: 10);
  }

  Widget _buildBalanceData(BuildContext context) {
    return Column(
            children: [
              Divider(color: context.colors.strokeColor, thickness: 1, height: 24.h,),
              Row(
                children: [
                  Text(
                    "صيانة اجهزة الكمبيوتر",
                    style: context.textStyles.font14MediumSecondaryColor,
                  ),
                  Spacer(),
                  Text(
                    "-500 د.ل",
                    style: context.textStyles.font16SemiBoldSecondaryColor.copyWith(
                      color: context.colors.redColor,
                    ),
                  ),
                ],
              ),
              20.verticalSizedBox,
              Row(
                children: [
                  Text(
                    "شراء لوازم مكتبية",
                    style: context.textStyles.font14MediumSecondaryColor,
                  ),
                  Spacer(),
                  Text(
                    "-1,200 د.ل",
                    style: context.textStyles.font16SemiBoldSecondaryColor.copyWith(
                      color: context.colors.redColor,
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}