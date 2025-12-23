import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TotalSection extends StatelessWidget {
  const TotalSection({super.key, required this.value});
  final String value ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 14.allPadding,
      decoration: BoxDecoration(
        color: context.colors.primaryColor.withValues(alpha: 0.06),
        border: Border.all(color: context.colors.primaryColor.withValues(alpha: 0.2), width: 1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(context.total, style: context.textStyles.font14MediumPrimaryColor,),
              Text(value, style: context.textStyles.font15SemiBoldSecondaryColor.copyWith(
                color: context.colors.primaryColor,
              ),),
            ],
          ),
        
          

        ],
      ),
    );
  }
}
