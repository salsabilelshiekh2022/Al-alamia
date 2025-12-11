import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:flutter/material.dart';

class CardWithPurpleShadow extends StatelessWidget {
  const CardWithPurpleShadow({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: context.colors.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadows: [
          BoxShadow(
            color: Color(0x336E0084),
            blurRadius: 20,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}

class CardWithWhiteShadow extends StatelessWidget {
  const CardWithWhiteShadow({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 10.allPadding,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: context.colors.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadows: [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 48,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
