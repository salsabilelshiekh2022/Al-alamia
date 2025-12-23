import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/app_extention.dart';
import '../../../../../core/helper/number_extentions.dart';
import '../../../../../core/helper/translation_extensions.dart';

class CurrencyBalanceItemInReports extends StatefulWidget {
  const CurrencyBalanceItemInReports({super.key});

  @override
  State<CurrencyBalanceItemInReports> createState() => _CurrencyBalanceItemInReportsState();
}

class _CurrencyBalanceItemInReportsState extends State<CurrencyBalanceItemInReports> {
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
            Text("الدينار الليبي", style: context.textStyles.font14MediumGrayColor,),
            Spacer(),
            Text("45,000 د.ل", style: context.textStyles.font17SemiBoldSecondaryColor.copyWith(
              fontWeight: FontWeight.w500,
            ),
            ),
            6.horizontalSizedBox,
            Icon(openDrowpdown ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down_rounded, size: 24.w, color: context.colors.secondaryColor,),
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
                    context.transfer,
                    style: context.textStyles.font14SemiBoldSecondaryColor,
                  ),
                  Spacer(),
                  Text(
                    "3,000 دولار",
                    style: context.textStyles.font16SemiBoldSecondaryColor.copyWith(
                      color: Color(0xff3EB655),
                    ),
                  ),
                ],
              ),
              20.verticalSizedBox,
              Row(
                children: [
                  Text(
                    context.outgoing,
                    style: context.textStyles.font14SemiBoldSecondaryColor,
                  ),
                  Spacer(),
                  Text(
                    "1,500 دولار",
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