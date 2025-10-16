import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({super.key, required this.title, required this.text});
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textStyles.font15SemiBoldSecondaryColor),
        10.verticalSizedBox,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          decoration: BoxDecoration(
            color: context.colors.backgroundFieldColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: context.colors.strokeColor, width: 1),
          ),
          child: Row(
            children: [
              Text(text, style: context.textStyles.font16MediumSecondaryColor),
              Spacer(),
              Icon(Icons.keyboard_arrow_down, color: context.colors.grayColor),
            ],
          ),
        ),
      ],
    );
  }
}
