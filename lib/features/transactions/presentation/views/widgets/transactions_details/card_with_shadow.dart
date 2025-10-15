import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:flutter/material.dart';

class CardWithShadow extends StatelessWidget {
  const CardWithShadow({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 18.allPadding,
      decoration: ShapeDecoration(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
