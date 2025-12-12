import 'package:alalamia/core/helper/app_extention.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../../generated/app_assets.dart';

class CurrencySwapButton extends StatelessWidget {
  const CurrencySwapButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(38 / 2),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(38 / 2),
          color: context.colors.primaryColor,
        ),
        child: Center(
          child: CustomSvgBuilder(
            path: AppAssets.svgsTransfarIcon,
            width: 21,
            height: 21,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
