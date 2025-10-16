import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'currency_calculator.dart';

class CurrencyCalculatorSection extends StatelessWidget {
  const CurrencyCalculatorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.currencyCalculator,
          style: context.textStyles.font16SemiBoldSecondaryColor,
        ),
        14.verticalSpace,
        CurrencyCalculator(),
      ],
    );
  }
}
