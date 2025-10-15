import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../../generated/app_assets.dart';
import 'card_with_shadow.dart';

class TransferedAmountInfoWidget extends StatelessWidget {
  const TransferedAmountInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWithShadow(
      child: Column(
        children: [
          Text(context.transeferedAmount, style: context.textStyles.font15MediumGrayColor,),
          14.verticalSizedBox,
          Text("\$1,250.30" , style: context.textStyles.font24BoldSecondaryColor,),
          14.verticalSizedBox,
          Text(context.dollar, style: context.textStyles.font14RegularPrimaryColor,),
          Divider(
            color: context.colors.strokeColor,
            thickness: 1,
          ).verticalPadding(14).horizontalPadding(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomSvgBuilder(path: AppAssets.svgsMapIcon, width: 20, height: 20,fit: BoxFit.scaleDown,),
                  10.verticalSizedBox,
                  Text("22-544" , style: context.textStyles.font14RegularSecondaryColor,),
                ],
              ),
              Icon(Icons.arrow_forward_sharp, color: context.colors.primaryColor,),
               Column(
                children: [
                  CustomSvgBuilder(path: AppAssets.svgsMapIcon, width: 20, height: 20,fit: BoxFit.scaleDown,),
                  10.verticalSizedBox,
                  Text("22-544" , style: context.textStyles.font14RegularSecondaryColor,),
                ],
              ),
            ],
          ).horizontalPadding(30)
        ],
      ),
    );
  }
}