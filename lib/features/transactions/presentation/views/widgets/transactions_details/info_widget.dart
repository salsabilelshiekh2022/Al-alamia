import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/components/widgets/custom_svg_builder.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    super.key, required this.title, required this.value, required this.icon,
  });
  final String title , value , icon;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
        CustomSvgBuilder(path: icon, width: 20, height: 20, fit: BoxFit.scaleDown,),
        11.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.textStyles.font14RegularGrayColor,),
            8.verticalSizedBox,
            Text(value, style: context.textStyles.font14RegularSecondaryColor,),
          ],
        )
      ]);
  }
}
