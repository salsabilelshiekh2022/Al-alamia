import 'package:alalamia/core/helper/app_extention.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/components/widgets/custom_svg_builder.dart';

class CurrencySwapButton extends StatelessWidget {
  const CurrencySwapButton({
    super.key,
    required this.onPressed,
    required this.iconPath,
    this.size = 38,
    this.iconSize = 21,
  });

  final VoidCallback onPressed;
  final String iconPath;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: context.colors.primaryColor,
        ),
        child: Center(
          child: CustomSvgBuilder(
            path: iconPath,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
