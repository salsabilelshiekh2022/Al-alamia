import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../generated/app_assets.dart';

class TransactionFromTo extends StatelessWidget {
  const TransactionFromTo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${context.from}:", style:  context.textStyles.font14RegularGrayColor,),
              Text("احمد محمد" , style:  context.textStyles.font14RegularSecondaryColor,).verticalPadding(8),
              Text("+20 150 1522 2030" , style:  context.textStyles.font14RegularGrayColor,),
          ],
        ),
        CustomSvgBuilder(path: AppAssets.svgsDoubleArrowIcon, width: 24, height: 24,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${context.to}:", style:  context.textStyles.font14RegularGrayColor,),
              Text("احمد محمد" , style:  context.textStyles.font14RegularSecondaryColor,).verticalPadding(8),
              Text("+20 150 1522 2030" , style:  context.textStyles.font14RegularGrayColor,),
          ],
        ),
      

      ],
    );
  }
}

