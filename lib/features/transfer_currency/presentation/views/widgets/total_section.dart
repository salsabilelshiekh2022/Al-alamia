import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TotalSection extends StatelessWidget {
  const TotalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 28, right: 28),
      decoration: BoxDecoration(
        color: context.colors.primaryColor.withValues(alpha: 0.03),
        border: Border.all(
          color: context.colors.primaryColor.withValues(alpha: 0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Text(
            " EGP 4,850.00",
            style: context.textStyles.font22BoldPrimaryColor,
          ),
          12.verticalSizedBox,
          Text(
            "${context.exchangeRate} : ١  ${context.dollar} = EGP 48.50",
            style: context.textStyles.font14MediumSecondaryColor,
          ),
        ],
      ),
    );
  }
}
