import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:flutter/material.dart';

class CardWithShadow extends StatelessWidget {
  const CardWithShadow({super.key, required this.child, this.borderRadius, this.padding});
  final Widget child;
  final double? borderRadius;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:padding != null ? padding!.allPadding : 18.allPadding,
      decoration: ShapeDecoration(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 12)),
    shadows: [
      BoxShadow(
        color: Color(0x26000000),
        blurRadius: 5,
        offset: Offset(0, 0),
        spreadRadius: 0,
      )

    ],
  ),
  child: child,
    );
  }
}
