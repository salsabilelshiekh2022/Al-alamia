import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../../generated/app_assets.dart';

class LogoutSection extends StatelessWidget {
  const LogoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: context.colors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Color(0xff6E0084).withValues(alpha: 0.2),
              blurRadius: 20.r,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            Text(context.logout,style: context.textStyles.font16RegularSecondaryColor.copyWith(color: context.colors.redColor),),
            10.horizontalSpace,
             CustomSvgBuilder(
              path: AppAssets.svgsLogoutIcon,
              width: 24,
              height: 24
            ),
          ],
        ),
      ),
    );
  }
}

