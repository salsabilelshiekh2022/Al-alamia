import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';
import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../generated/app_assets.dart';
import '../../../../home/presentation/views/widgets/calculator/calculator_text_field.dart';

class ConversionDatacard extends StatelessWidget {
  const ConversionDatacard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWithPurpleShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.conversionData,
            style: context.textStyles.font16SemiBoldSecondaryColor,
          ),
          12.verticalSizedBox,
          Text(context.amount, style: context.textStyles.font15MediumGrayColor),
          16.verticalSizedBox,
          Row(
            children: [
              Image.asset(
                AppAssets.imagesFlag,
                width: 26,
                height: 26,
                fit: BoxFit.fill,
              ).clipRRect(borderRadius: BorderRadius.circular(13)),
              11.horizontalSpace,
              Text(
                context.dollar,
                style: context.textStyles.font16MediumPrimaryColor,
              ),
              10.horizontalSpace,
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xff3C3C3C),
                ),
              ),
              25.horizontalSpace,
              CalculatorTextField(),
            ],
          ),
          35.verticalSpace,
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Divider(color: context.colors.strokeColor),
              PositionedDirectional(
                top: -18,

                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: 22.allBorderRadius,
                    color: context.colors.primaryColor,
                  ),
                  child: CustomSvgBuilder(
                    path: AppAssets.svgsTransfarIcon,
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ],
          ),
          25.verticalSizedBox,
          Row(
            children: [
              Image.asset(
                AppAssets.imagesFlag,
                width: 26,
                height: 26,
                fit: BoxFit.fill,
              ).clipRRect(borderRadius: BorderRadius.circular(13)),
              11.horizontalSpace,
              Text(
                context.dollar,
                style: context.textStyles.font16MediumPrimaryColor,
              ),
              10.horizontalSpace,
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xff3C3C3C),
                ),
              ),
              25.horizontalSpace,
              CalculatorTextField(),
            ],
          ),
        ],
      ),
    );
  }
}
