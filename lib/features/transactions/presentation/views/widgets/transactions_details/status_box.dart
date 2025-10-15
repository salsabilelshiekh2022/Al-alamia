import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../../generated/app_assets.dart';

class StatusBox extends StatelessWidget {
  const StatusBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 20.allPadding,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0x2800840F),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 25,
            offset: Offset(0, 11),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 45,
            offset: Offset(0, 45),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 61,
            offset: Offset(0, 101),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x00000000),
            blurRadius: 72,
            offset: Offset(0, 180),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x00000000),
            blurRadius: 79,
            offset: Offset(0, 280),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          CustomSvgBuilder(
            path: AppAssets.svgsPending,
            width: 36,
            height: 36,
            fit: BoxFit.scaleDown,
          ),
          12.horizontalSpace,
          Text(
            context.pending,
            style: context
                .textStyles
                .font18SemiBoldSecondaryColor
                .copyWith(color: context.colors.yellowColor),
          ),
        ],
      ),
    );
  }
}


