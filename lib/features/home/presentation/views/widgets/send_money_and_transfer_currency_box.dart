import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../generated/app_assets.dart';

class SendMoneyAndTransferCurrencyBox extends StatelessWidget {
  const SendMoneyAndTransferCurrencyBox({super.key});

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: 20,
      start: 16,
      end: 16,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 13, horizontal: 55),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: const Color(0x2800840F)),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {},
              child: Column(
                children: [
                  CustomSvgBuilder(
                    path: AppAssets.svgsSendMoneyIcon,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                  6.verticalSizedBox,
                  Text(
                    context.sendMoney,
                    style: context.textStyles.font13SemiBoldPrimaryColor,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                context.pushNamed(Routes.transferCurrencyView);
              },
              child: Column(
                children: [
                  CustomSvgBuilder(
                    path: AppAssets.svgsPurpleTransfarIcon,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                  6.verticalSizedBox,
                  Text(
                    context.currencyTransfer,
                    style: context.textStyles.font13SemiBoldPrimaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
