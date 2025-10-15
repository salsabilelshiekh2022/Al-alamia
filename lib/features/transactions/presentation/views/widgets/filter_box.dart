import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../generated/app_assets.dart';

class FilterBox extends StatelessWidget {
  const FilterBox({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        padding: 12.allPadding,
        decoration: BoxDecoration(
          color: context.colors.whiteColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: context.colors.whiteColor.withValues(alpha: 0.22), width: 1),
          
        ),
        child: CustomSvgBuilder(path: AppAssets.svgsFilterIcon, width: 24, height: 24, fit: BoxFit.scaleDown),
      ),
    );
  }
}