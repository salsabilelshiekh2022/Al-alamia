import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/enums/reports_enum.dart';

class ReportsFilterType extends StatefulWidget {
  const ReportsFilterType({super.key});

  @override
  State<ReportsFilterType> createState() => _ReportsFilterTypeState();
}

class _ReportsFilterTypeState extends State<ReportsFilterType> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 6.allPadding,
      width: double.infinity,
      height: 45.h,
      decoration: BoxDecoration(
        color: context.colors.backgroundFieldColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: List.generate(
          ReportsEnum.values.length,

          (index) => Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2),
                padding: 5.allPadding,
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? context.colors.whiteColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    ReportsEnum.values[index].translate(context),
                    style: selectedIndex == index
                        ? context.textStyles.font16MediumPrimaryColor
                        : context.textStyles.font16MediumSecondaryColor
                              .copyWith(color: context.colors.grayColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
