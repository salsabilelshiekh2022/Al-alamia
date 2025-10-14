import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/components/widgets/custom_cache_network_image.dart';

class UserInfoBox extends StatelessWidget {
  const UserInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 15.allPadding,
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "احمد محمد",
                style: context.textStyles.font13SemiBoldPrimaryColor.copyWith(
                  color: context.colors.secondaryColor,
                ),
              ),
              5.verticalSpace,
              Text(
                context.egyptBranch,
                style: context.textStyles.font14RegularGrayColor
              ),
                5.verticalSpace,
              Text(
                "+20123456789",
                style: context.textStyles.font14RegularGrayColor
              ),
            ],
          ),
          8.horizontalSpace,
          ClipRRect(
            borderRadius: 25.allBorderRadius,
            child: CustomCachedImageWidget(
              path:
                  "https://i.pinimg.com/736x/5f/94/15/5f9415114f1e9bf75b48d52221e15414.jpg",
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
